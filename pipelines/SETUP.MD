# Azure DevOps YAML Training Setup Checklist for Students

This checklist provides exact commands to set up the complete Azure DevOps YAML pipeline training environment for **one student**. Repeat these steps for each of the 4 students.

---

## Prerequisites
- Azure DevOps organization: `https://dev.azure.com/mcapdevopsorg`
- GitHub repository: `https://github.com/tdevere/ADO_YAML_LABS`
- Azure CLI installed with `azure-devops` extension
- Git installed
- Access to `.env` file with PATs and service connection IDs

---

## Setup Steps for One Student

### Step 1: Create Azure DevOps Project
```bash
# Set defaults for Azure DevOps CLI
az devops configure --defaults organization=https://dev.azure.com/mcapdevopsorg

# Create new project (replace STUDENT_NAME with actual name, e.g., Student1)
az devops project create --name "ADO_Training_STUDENT_NAME" --description "YAML Pipeline Training for STUDENT_NAME" --visibility private

# Set the new project as default
az devops configure --defaults project=ADO_Training_STUDENT_NAME
```

### Step 2: Create GitHub Service Connection
```bash
# Get the project ID (needed for service connection)
$projectId = az devops project show --project ADO_Training_STUDENT_NAME --query id -o tsv

# Create GitHub service connection (requires GitHub PAT from .env)
# Note: This creates a service connection named "GitHub_STUDENT_NAME"
az devops service-endpoint github create --name "GitHub_STUDENT_NAME" --github-url https://github.com/tdevere/ADO_YAML_LABS --project ADO_Training_STUDENT_NAME

# Get the service connection ID (save this for pipeline creation)
$serviceConnectionId = az devops service-endpoint list --project ADO_Training_STUDENT_NAME --query "[?name=='GitHub_STUDENT_NAME'].id" -o tsv
echo "Service Connection ID: $serviceConnectionId"
```

### Step 3: Create Agent Pool (Optional - if using self-hosted agents)
```bash
# Create agent pool named "Default" for the student project
az pipelines pool create --name "Default" --project ADO_Training_STUDENT_NAME --pool-type Hosted

# OR if using existing organization-level pool, grant access:
az pipelines pool list --pool-name "Default" --query "[0].id" -o tsv
# Then grant project access in Azure DevOps UI: Organization Settings > Agent Pools > Default > Security > Add project
```

### Step 4: Create Pipelines (All 7 Examples)

#### Pipeline 1: Working Example
```bash
az pipelines create --name "01-working-example" --description "Working YAML pipeline example" --repository https://github.com/tdevere/ADO_YAML_LABS --repository-type github --branch main --yaml-path "pipelines/01-working-example.yml" --service-connection $serviceConnectionId --project ADO_Training_STUDENT_NAME
```

#### Pipeline 2: Syntax Errors
```bash
az pipelines create --name "02-syntax-errors" --description "YAML syntax and indentation errors" --repository https://github.com/tdevere/ADO_YAML_LABS --repository-type github --branch main --yaml-path "pipelines/02-syntax-errors.yml" --service-connection $serviceConnectionId --project ADO_Training_STUDENT_NAME
```

#### Pipeline 3: Pool Errors
```bash
az pipelines create --name "03-pool-errors" --description "Agent pool configuration errors" --repository https://github.com/tdevere/ADO_YAML_LABS --repository-type github --branch main --yaml-path "pipelines/03-pool-errors.yml" --service-connection $serviceConnectionId --project ADO_Training_STUDENT_NAME
```

#### Pipeline 4: Variable Errors
```bash
az pipelines create --name "04-variable-errors" --description "Variable expression errors" --repository https://github.com/tdevere/ADO_YAML_LABS --repository-type github --branch main --yaml-path "pipelines/04-variable-errors.yml" --service-connection $serviceConnectionId --project ADO_Training_STUDENT_NAME
```

#### Pipeline 5: Task Errors
```bash
az pipelines create --name "05-task-errors" --description "Task dependency and input errors" --repository https://github.com/tdevere/ADO_YAML_LABS --repository-type github --branch main --yaml-path "pipelines/05-task-errors.yml" --service-connection $serviceConnectionId --project ADO_Training_STUDENT_NAME
```

#### Pipeline 6: Trigger Syntax Errors
```bash
az pipelines create --name "06-trigger-syntax-errors" --description "Trigger syntax errors" --repository https://github.com/tdevere/ADO_YAML_LABS --repository-type github --branch main --yaml-path "pipelines/06-trigger-syntax-errors.yml" --service-connection $serviceConnectionId --project ADO_Training_STUDENT_NAME
```

#### Pipeline 7: Job Condition Errors
```bash
az pipelines create --name "07-job-conditions-errors" --description "Job condition and dependency errors" --repository https://github.com/tdevere/ADO_YAML_LABS --repository-type github --branch main --yaml-path "pipelines/07-job-conditions-errors.yml" --service-connection $serviceConnectionId --project ADO_Training_STUDENT_NAME
```

### Step 5: Verify Setup
```bash
# List all pipelines in the project
az pipelines list --project ADO_Training_STUDENT_NAME --output table

# Verify service connection
az devops service-endpoint list --project ADO_Training_STUDENT_NAME --output table
```

### Step 6: Grant Student Access
```bash
# Add student to project as Contributor (replace with student email/UPN)
az devops user add --email-id student@example.com --license-type express --project ADO_Training_STUDENT_NAME

# OR add to project via Azure DevOps UI:
# Project Settings > Teams > Add > Search for student > Add as Contributor
```

---

## Checklist Summary

- [ ] **Step 1**: Create Azure DevOps project `ADO_Training_STUDENT_NAME`
- [ ] **Step 2**: Create GitHub service connection `GitHub_STUDENT_NAME` and save service connection ID
- [ ] **Step 3**: Create or grant access to agent pool `Default`
- [ ] **Step 4**: Create all 7 pipelines (01-07)
- [ ] **Step 5**: Verify pipelines and service connection
- [ ] **Step 6**: Grant student Contributor access to project

---

## Notes for Multiple Students

### Repeat for Each Student:
1. Replace `STUDENT_NAME` in commands (e.g., `Student1`, `Student2`, `Student3`, `Student4`)
2. Use unique project names: `ADO_Training_Student1`, `ADO_Training_Student2`, etc.
3. Use unique service connection names: `GitHub_Student1`, `GitHub_Student2`, etc.
4. Save each student's service connection ID for pipeline creation

### PowerShell Script Template (Optional Automation)
If you want to automate this for all 4 students, save this as `setup-student.ps1`:

```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$StudentName,
    
    [Parameter(Mandatory=$true)]
    [string]$StudentEmail
)

$projectName = "ADO_Training_$StudentName"
$serviceConnectionName = "GitHub_$StudentName"
$orgUrl = "https://dev.azure.com/mcapdevopsorg"
$repoUrl = "https://github.com/tdevere/ADO_YAML_LABS"

# Set defaults
az devops configure --defaults organization=$orgUrl

# Create project
Write-Host "Creating project: $projectName"
az devops project create --name $projectName --description "YAML Pipeline Training for $StudentName" --visibility private

# Set project default
az devops configure --defaults project=$projectName

# Create service connection
Write-Host "Creating GitHub service connection: $serviceConnectionName"
az devops service-endpoint github create --name $serviceConnectionName --github-url $repoUrl --project $projectName

# Get service connection ID
$serviceConnectionId = az devops service-endpoint list --project $projectName --query "[?name=='$serviceConnectionName'].id" -o tsv
Write-Host "Service Connection ID: $serviceConnectionId"

# Create pipelines
$pipelines = @(
    @{name="01-working-example"; desc="Working YAML pipeline example"; path="pipelines/01-working-example.yml"},
    @{name="02-syntax-errors"; desc="YAML syntax and indentation errors"; path="pipelines/02-syntax-errors.yml"},
    @{name="03-pool-errors"; desc="Agent pool configuration errors"; path="pipelines/03-pool-errors.yml"},
    @{name="04-variable-errors"; desc="Variable expression errors"; path="pipelines/04-variable-errors.yml"},
    @{name="05-task-errors"; desc="Task dependency and input errors"; path="pipelines/05-task-errors.yml"},
    @{name="06-trigger-syntax-errors"; desc="Trigger syntax errors"; path="pipelines/06-trigger-syntax-errors.yml"},
    @{name="07-job-conditions-errors"; desc="Job condition and dependency errors"; path="pipelines/07-job-conditions-errors.yml"}
)

foreach ($pipeline in $pipelines) {
    Write-Host "Creating pipeline: $($pipeline.name)"
    az pipelines create --name $pipeline.name --description $pipeline.desc --repository $repoUrl --repository-type github --branch main --yaml-path $pipeline.path --service-connection $serviceConnectionId --project $projectName --skip-run
}

# List pipelines
Write-Host "`nPipelines created:"
az pipelines list --project $projectName --output table

Write-Host "`nSetup complete for $StudentName. Remember to grant access to: $StudentEmail"
```

**Run for each student:**
```powershell
.\setup-student.ps1 -StudentName "Student1" -StudentEmail "student1@example.com"
.\setup-student.ps1 -StudentName "Student2" -StudentEmail "student2@example.com"
.\setup-student.ps1 -StudentName "Student3" -StudentEmail "student3@example.com"
.\setup-student.ps1 -StudentName "Student4" -StudentEmail "student4@example.com"
```

---

## Expected Outcome
Each student will have:
- Dedicated Azure DevOps project: `ADO_Training_StudentX`
- 7 pipelines (1 working, 6 with intentional errors)
- Access to GitHub repo via service connection
- Contributor permissions to troubleshoot and fix pipelines
