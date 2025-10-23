<#
.SYNOPSIS
  Create one Azure DevOps pipeline per YAML file in the `pipelines/` folder.

.DESCRIPTION
  Reads a local `.env` file at repository root for configuration values and

.NOTES
  - Requires Azure CLI and the `azure-devops` extension.
  - Do NOT commit `.env` to source control. The repo's .gitignore already excludes it.
#>

param(
  [switch]$Execute,
  [switch]$DryRun,
  [string]$RepoRoot = "C:\\ADO\\ADO_YAML_LABS",
  [string]$PipelinesFolder = "pipelines",
  [string]$DefaultBranch = "main",
  [string]$ServiceConnectionId = ""
)

Set-StrictMode -Version Latest

function Read-EnvFile([string]$path) {
  $map = @{}
  if (-not (Test-Path $path)) { return $map }
  Get-Content $path | ForEach-Object {
      if ($_ -match '^\s*#') { return }
      $line = $_.Trim()
      if ($line -and $line -match '^(\w+)\s*=\s*(.+)$') {
  $k = $matches[1]
  # Trim surrounding single or double quotes if present
  $v = $matches[2].Trim().Trim('"', "'")
  $map[$k] = $v
      }
  }
  return $map
}

Write-Host "RepoRoot: $RepoRoot" -ForegroundColor Cyan

$envFile = Join-Path $RepoRoot ".env"
$cfg = Read-EnvFile $envFile

if ($cfg.ContainsKey('DevOpsOrgUrl')) { $org = $cfg['DevOpsOrgUrl'] } else { $org = Read-Host 'Azure DevOps organization URL (e.g. https://dev.azure.com/ORG)'}
if ($cfg.ContainsKey('DevOpsOrgProject')) { $project = $cfg['DevOpsOrgProject'] } else { $project = Read-Host 'Azure DevOps project name' }
if ($cfg.ContainsKey('GitHubRepoUrl')) { $repo = $cfg['GitHubRepoUrl'] } else { $repo = Read-Host 'GitHub repo URL (HTTPS)'}
if (-not $ServiceConnectionId -and $cfg.ContainsKey('DevOpsServiceConnectionId')) { $ServiceConnectionId = $cfg['DevOpsServiceConnectionId'] }

# If a DevOps PAT is present in .env, use it to authenticate non-interactively.
if ($cfg.ContainsKey('DevOpsPAT')) {
  try {
    Write-Host "Using DevOps PAT from .env to authenticate to Azure DevOps (token not displayed)." -ForegroundColor Yellow
    $pat = $cfg['DevOpsPAT']
    # Set environment variable the azure-devops extension will honor
    $env:AZURE_DEVOPS_EXT_PAT = $pat
    # Also set AZURE_DEVOPS_EXT_PAT for child processes invoked by this script
    [System.Environment]::SetEnvironmentVariable('AZURE_DEVOPS_EXT_PAT', $pat, 'Process') | Out-Null
  } catch {
    Write-Warning "Could not set AZURE_DEVOPS_EXT_PAT: $_"
  }
}

if (-not (Get-Command az -ErrorAction SilentlyContinue)) {
  Write-Error "Azure CLI 'az' not found in PATH. Install it first: https://aka.ms/azcli"
  exit 2
}

# Ensure azure-devops extension installed
try {
  $exts = az extension list --output json | ConvertFrom-Json
  if (-not ($exts | Where-Object { $_.name -eq 'azure-devops' })) {
    Write-Host "Installing azure-devops extension..."
    az extension add --name azure-devops | Out-Null
  }
} catch {
  Write-Warning "Could not ensure azure-devops extension: $_"
}


Write-Host "Using organization: $org" -ForegroundColor Green
Write-Host "Using project: $project" -ForegroundColor Green
Write-Host "Using repo: $repo" -ForegroundColor Green

az devops configure --defaults "organization=$org" "project=$project" | Out-Null

$searchRoot = Join-Path $RepoRoot $PipelinesFolder
if (-not (Test-Path $searchRoot)) {
  Write-Error "Pipelines folder not found: $searchRoot"
  exit 1
}

$yamlFiles = Get-ChildItem -Path $searchRoot -Recurse -Filter *.yml -File | Sort-Object FullName
if (-not $yamlFiles) { Write-Host "No .yml files found under $searchRoot"; exit 0 }

# Normalize repo root and compute relative paths robustly (portable fallback)
$repoRootNormalized = (Resolve-Path $RepoRoot).Path.TrimEnd('\','/')
foreach ($file in $yamlFiles) {
  $filePath = (Resolve-Path $file.FullName).Path
  if ($filePath.StartsWith($repoRootNormalized, [System.StringComparison]::OrdinalIgnoreCase)) {
    $rel = $filePath.Substring($repoRootNormalized.Length).TrimStart('\','/') -replace '\\','/'
  } else {
    # Fallback: just use file name under pipelines folder
    $rel = Join-Path $PipelinesFolder $file.Name -replace '\\','/'
  }
  $name = "yaml: $rel"

  $azArgs = @(
    'pipelines', 'create',
    '--name', $name,
    '--repository', $repo,
    '--repository-type', 'github',
    '--branch', $DefaultBranch,
    '--yml-path', $rel,
    '--skip-run'
  )
  if ($ServiceConnectionId) { $azArgs += @('--service-connection', $ServiceConnectionId) }

  if ($DryRun -and -not $Execute) {
    Write-Host "DRYRUN: az $($azArgs -join ' ')" -ForegroundColor Yellow
  } else {
    Write-Host "Executing: az $($azArgs -join ' ')" -ForegroundColor Cyan
    try {
      $out = az @azArgs | Out-String
      Write-Host $out
    } catch {
      Write-Warning "Failed to create pipeline $name"
      Write-Warning $_
    }
  }
}

Write-Host "Finished. If you ran with -Execute, review pipelines in your Azure DevOps project." -ForegroundColor Green
