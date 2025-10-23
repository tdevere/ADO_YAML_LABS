# Test Project - YAML Pipeline Examples

Simple .NET 6.0 console app for validating Azure DevOps YAML pipelines.

## 📦 Project Contents

- **BuildTestApp.csproj** — Main application (console exe)
- **Program.cs** — Entry point with environment diagnostics
- **UnitTests.csproj** — XUnit test project
- **UnitTests.cs** — Example unit tests

## 🚀 Build & Run Locally

### Prerequisites
- **.NET 6.0 SDK** or later ([download](https://dotnet.microsoft.com/download))

### Build
```bash
dotnet build
```

### Run
```bash
dotnet run --project BuildTestApp.csproj
```

Expected output:
```
=== Build Test Application ===
Environment: local
Build Number: local-build
Source Branch: unknown

✅ Math test passed
✅ String test passed
⚠️  Agent name not set (expected in pipeline context)
✅ All checks passed!
```

### Run Tests
```bash
dotnet test UnitTests.csproj
```

## 🔧 What It Tests

1. **Basic compilation** — Verifies .NET SDK works
2. **Math operations** — Simple logic test
3. **String operations** — String handling
4. **Environment variables** — Reads `AGENT_NAME`, `BUILD_BUILDNUMBER`, etc.
5. **Exit codes** — Returns 0 on success, 1 on failure

## 🎯 Why This Project?

✅ **Cross-platform** — Works on Linux, Windows, macOS agents  
✅ **Minimal dependencies** — Only uses .NET standard library  
✅ **Quick feedback** — Builds in < 5 seconds  
✅ **Diagnostic output** — Prints agent info for troubleshooting  
✅ **Test-ready** — Includes XUnit for advanced pipelines  

## 📊 Used By

- `01-working-example.yml` — Reference implementation
- `02-syntax-errors.yml` — Syntax testing
- `03-pool-errors.yml` — Agent pool validation
- `04-variable-errors.yml` — Variable expansion testing
- `05-task-errors.yml` — Task dependency testing
- `06-trigger-errors.yml` — Trigger and condition testing

## 🔍 Environment Variables (Set by Pipeline)

| Variable | Set By | Usage |
|----------|--------|-------|
| `BUILD_ENV` | Custom task | Application environment |
| `BUILD_BUILDNUMBER` | Azure Pipelines | Build identifier |
| `BUILD_SOURCEBRANCH` | Azure Pipelines | Current branch ref |
| `AGENT_NAME` | Azure Pipelines agent | Agent identifier |

## 📝 Notes

- Source files excluded from GitHub (see `.gitignore`)
- Local builds useful for quick validation
- Azure Pipeline runs this against real agents
- Tests verify basic functionality works before production

---

**Last Updated:** 2025-10-23  
**Framework:** .NET 6.0  
**License:** Training material
