# 📚 YAML Pipeline Troubleshooting Examples & Test Project

This repository contains YAML pipeline examples for **Azure DevOps troubleshooting training**, paired with a simple .NET test application.

---

## 🎯 Purpose

Each YAML pipeline in `pipelines/` demonstrates a common YAML issue encountered in enterprise Azure DevOps support:

| Pipeline | Issue Category | Complexity |
|----------|---|---|
| `01-working-example.yml` | ✅ Reference Implementation | Basic |
| `02-syntax-errors.yml` | ❌ Indentation & Syntax | Common (30%) |
| `03-pool-errors.yml` | ❌ Pool Configuration | Common (25%) |
| `04-variable-errors.yml` | ❌ Variable Expressions | Complex (20%) |
| `05-task-errors.yml` | ❌ Task Dependencies | Intermediate (15%) |
| `06-trigger-syntax-errors.yml` | ❌ Trigger Syntax | Intermediate (10%) |
| `07-job-conditions-errors.yml` | ❌ Job Conditions & Dependencies | Intermediate (10%) |

---

## 📂 Repository Structure

```
ADO_YAML_LABS/
├── pipelines/                    # 🔵 ALL YAML EXAMPLES (published to GitHub)
│   ├── 01-working-example.yml    # ✅ Reference: clean, working pipeline
│   ├── 02-syntax-errors.yml      # ❌ Problem: indentation issues
│   ├── 03-pool-errors.yml        # ❌ Problem: agent pool misconfiguration
│   ├── 04-variable-errors.yml    # ❌ Problem: variable syntax errors
│   ├── 05-task-errors.yml        # ❌ Problem: task input/dependency errors
│   ├── 06-trigger-errors.yml     # ❌ Problem: trigger condition errors
│   └── README.md                 # This file
│
├── test-project/                 # 🟢 TEST APPLICATION (local only)
│   ├── BuildTestApp.csproj       # Main .NET 6.0 console app
│   ├── Program.cs                # Simple build/test executable
│   ├── UnitTests.csproj          # XUnit test project
│   └── UnitTests.cs              # Example unit tests
│
└── .gitignore                    # 🔵 Only .yml files pushed to GitHub
```

---

## 🚀 Quick Start

### 1. **Clone & Review**
```bash
git clone https://github.com/<owner>/ADO_YAML_LABS.git
cd ADO_YAML_LABS
```

### 2. **Start with Working Example**
Open `pipelines/01-working-example.yml` to see correct YAML syntax.

### 3. **Compare with Broken Examples**
Compare any broken pipeline (`02-06`) with the working example to spot errors.

### 4. **Check Solutions (Local)**
Open `SOLUTIONS.md` (in your local repo only) for detailed explanations:
- What's wrong and why
- How to fix it
- Why that pattern causes issues

### 5. **Test Against Project**
The test project in `test-project/` works with any pipeline. Build it:
```bash
cd test-project
dotnet build
dotnet run
```

---

## 🔧 Using in Azure DevOps

### **Setup Once:**
1. Create GitHub service connection in Azure DevOps
2. Install Azure DevOps CLI

### **Auto-Create Pipelines:**
Run the provided PowerShell script (see parent `README.md`):
```powershell
# Creates one pipeline per YAML file in pipelines/
.\create-pipelines.ps1
```

Each pipeline will:
- Name itself after the YAML file: `yaml: pipelines/01-working-example.yml`
- Point to the GitHub repo
- Be ready to run immediately

---

## 📝 Understanding Error Categories

### **1️⃣ Syntax Errors (30% of tickets)**
- **File:** `02-syntax-errors.yml`
- **Issue:** Inconsistent indentation, wrong nesting
- **Solution:** Check alignment against `01-working-example.yml`
- **Tools:** VS Code YAML extension shows red squiggles

### **2️⃣ Pool Errors (25% of tickets)**
- **File:** `03-pool-errors.yml`
- **Issue:** Deprecated images, wrong pool syntax
- **Solution:** Use `windows-2022` or `ubuntu-latest`
- **Impact:** Pipeline won't run or fails on agent discovery

### **3️⃣ Variable Expression Errors (20% of tickets)**
- **File:** `04-variable-errors.yml`
- **Issue:** Mixed syntax (`$()`, `${{}}`, `$[]`)
- **Solution:** Use `$()` in scripts, `$[]` in conditions
- **Debug:** Print variables to see actual values

### **4️⃣ Task/Dependency Errors (15% of tickets)**
- **File:** `05-task-errors.yml`
- **Issue:** Missing inputs, wrong job names, bad dependencies
- **Solution:** Check task docs, verify names match exactly
- **Prevent:** Use clear naming conventions

### **5️⃣ Trigger Syntax Errors (10% of tickets)**
- **File:** `06-trigger-syntax-errors.yml`
- **Issue:** Invalid trigger syntax, conflicting schedules, bad branch patterns
- **Solution:** Use `branches: include/exclude` blocks; avoid conflicting filters
- **Test:** Check pipeline triggers in Azure DevOps UI

### **6️⃣ Job Conditions & Dependencies Errors (10% of tickets)**
- **File:** `07-job-conditions-errors.yml`
- **Issue:** Wrong condition syntax, mismatched job names, variable type errors
- **Solution:** Use boolean values in conditions; ensure job names match exactly
- **Debug:** Review job logs for condition evaluation

---

## 🧪 Test Project Details

**Purpose:** Simple, cross-platform app to validate YAML pipelines work.

**Features:**
- ✅ Runs on Windows & Linux agents
- ✅ Outputs agent info for diagnostics
- ✅ Uses standard .NET tooling (no custom frameworks)
- ✅ Includes XUnit tests for `DotNetCoreCLI@2` task testing
- ✅ Produces artifacts for `PublishBuildArtifacts@1` demo

**Build Locally:**
```bash
cd test-project
dotnet build
dotnet run
dotnet test
```

**Why This Project?**
- Familiar tech (C#/.NET) to most enterprises
- Works with any agent (Windows/Linux/Mac)
- Simple enough to focus on YAML, not application debugging
- Good platform for demonstrating pipeline tasks

---

## 📊 Support Ticket Workflow

Use these examples to handle common support requests:

**Customer:** *"My pipeline won't validate."*
→ Show `02-syntax-errors.yml` and `SOLUTIONS.md` Problem 1

**Customer:** *"Pipeline works locally but fails in Azure DevOps."*
→ Show `03-pool-errors.yml` and explain image deprecation

**Customer:** *"Variables aren't expanding."*
→ Show `04-variable-errors.yml` and explain `$()` vs `$[]` vs `${{}}`

**Customer:** *"Dependencies not working."*
→ Show `05-task-errors.yml` and verify job names, conditions

**Customer:** *"Pipeline doesn't trigger when I expect."*
→ Show `06-trigger-errors.yml` and explain trigger filters

---

## 🔐 What's NOT in GitHub

The `.gitignore` excludes:
- ✋ `SOLUTIONS.md` (reference guide with all fixes)
- ✋ `solutions/` folder (if you create detailed explanations)
- ✋ Test project source files (only `.yml` published)

**Why?** 
- Students use broken YAML to learn troubleshooting
- Solutions are for instructors/mentors only
- Test project stays local so learners can experiment

---

## 📚 Related Files

- **Lab Instructions:** See parent directory `lesson-*.md` files
- **Setup Guide:** Parent directory has full Azure DevOps setup
- **Solutions:** `SOLUTIONS.md` (local reference only)

---

## 🎓 Learning Path

### Beginner (< 1 hour)
1. Read `01-working-example.yml`
2. Try to spot errors in `02-syntax-errors.yml`
3. Check `SOLUTIONS.md` Problem 1

### Intermediate (2-3 hours)
1. Compare all 6 pipelines systematically
2. Try to run `01-working-example.yml` in Azure DevOps
3. Document what you learn for each error type

### Advanced (Full Lab - 4+ hours)
1. Create your own broken YAML examples
2. Use VS Code YAML extension for validation
3. Practice explaining fixes to non-technical users
4. Build troubleshooting cheat sheet

---

## ⚡ Quick Reference: Common Fixes

| Error | Fix |
|-------|-----|
| "Invalid YAML structure" | Check indentation (2-space rule) |
| "Image not found" | Update `vs2017-win2016` → `windows-2022` |
| "Variable empty/null" | Use `$()` not `${{}}` in script context |
| "Job not found" | Verify job name in `dependsOn:` matches exactly |
| "Trigger not firing" | Remove conflicting `include`/`exclude` filters |

---

## 🤝 Contributing

Adding new examples?
1. Create pipeline in `pipelines/01x-topic-errors.yml`
2. Document issue in `SOLUTIONS.md`
3. Ensure it fails meaningfully (good teaching value)
4. Test that `01-working-example.yml` still passes
5. Keep to one error category per file

---

## 📞 Support

Stuck? Check in this order:
1. `SOLUTIONS.md` (detailed explanations)
2. Azure Pipelines YAML docs (official reference)
3. Compare broken file to `01-working-example.yml` (visual comparison)

---

**Status:** ✅ Ready for classroom use | 📅 Updated: 2025-10-23
