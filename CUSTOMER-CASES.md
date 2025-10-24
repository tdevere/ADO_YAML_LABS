# Azure DevOps Pipeline Support Cases - Training Scenarios

This document simulates real customer support cases for Azure DevOps YAML pipeline troubleshooting. Each case represents a common issue that customers encounter.

---

## 📋 Case Information Template

- **Organization**: `https://dev.azure.com/mcapdevopsorg`
- **Project**: `ADO_Training_STUDENT_[ONE|TWO|THREE|FOUR]`
- **Repository**: `https://github.com/tdevere/ADO_YAML_LABS`
- **Support Level**: Standard
- **Priority**: Medium

---

## Case #01: Pipeline Permission Issue

### Customer Information
- **Organization**: `https://dev.azure.com/mcapdevopsorg`
- **Project**: `ADO_Training_STUDENT_ONE`
- **Pipeline Name**: `01-working-example`
- **Severity**: Low
- **Category**: Configuration / Permissions

### Problem Description (Customer's Words)
> "Hi, I created a new pipeline in Azure DevOps that connects to our GitHub repository. When I try to run it, I'm getting an error about needing to grant permission to access the repository. The pipeline YAML looks correct to me, and I can see the repo in GitHub just fine. Why isn't this working? Do I need special permissions?"

### Technical Details
- **Trigger**: Manual run or first-time CI trigger
- **Error Type**: Permission denied
- **YAML File**: `pipelines/01-working-example.yml`
- **Expected Behavior**: Pipeline should build .NET project successfully

### Resolution Steps
1. Navigate to the pipeline run in Azure DevOps
2. Look for the yellow/orange banner requesting permission
3. Click "View" or "Permit" to grant the pipeline access to the GitHub service connection
4. Re-run the pipeline
5. Verify successful execution

### Learning Objectives
- Understand Azure DevOps service connection authorization model
- Learn about first-run permission grants for pipelines
- Recognize permission-related error messages vs. YAML errors

---

## Case #02: YAML Syntax and Structure Errors

### Customer Information
- **Organization**: `https://dev.azure.com/mcapdevopsorg`
- **Project**: `ADO_Training_STUDENT_ONE`
- **Pipeline Name**: `02-syntax-errors`
- **Severity**: High
- **Category**: YAML Syntax / Pipeline Validation

### Problem Description (Customer's Words)
> "I'm trying to create a CI/CD pipeline for my .NET application, but Azure DevOps keeps rejecting my YAML file. I get validation errors when I try to save it, and the error messages mention something about 'mapping values' and 'indentation'. I copied this from our documentation and made some changes, but now nothing works. Can you help me understand what's wrong with the syntax?"

### Technical Details
- **Trigger**: Pipeline creation or YAML edit
- **Error Type**: YAML validation failure
- **YAML File**: `pipelines/02-syntax-errors.yml`
- **Common Errors**:
  - Incorrect indentation (mixing spaces/tabs)
  - Missing colons after keys
  - Improper nesting of job/task properties
  - Invalid multi-line script syntax

### Symptoms
- Pipeline fails validation before running
- Error messages reference line numbers and YAML structure
- Cannot save or queue the pipeline

### Learning Objectives
- Master YAML indentation rules (2 spaces, no tabs)
- Understand YAML key-value pair syntax
- Learn proper nesting for jobs, steps, and task inputs
- Practice reading YAML validation error messages
- Use YAML schema validation in VS Code

### Key Troubleshooting Questions
1. Are you using spaces (not tabs) for indentation?
2. Do all mapping keys have colons followed by values?
3. Are task inputs properly nested under the `inputs:` key?
4. Are multi-line scripts using the pipe `|` or `|-` syntax correctly?

---

## Case #03: Agent Pool Configuration Errors

### Customer Information
- **Organization**: `https://dev.azure.com/mcapdevopsorg`
- **Project**: `ADO_Training_STUDENT_TWO`
- **Pipeline Name**: `03-pool-errors`
- **Severity**: High
- **Category**: Agent Pool / Infrastructure

### Problem Description (Customer's Words)
> "Our pipeline is failing immediately with an error about 'pool not found' or something about agents. We recently migrated from the old YAML syntax, and I think we might have the pool configuration wrong. I tried using 'vmImage' but it's still not working. We want to use Microsoft-hosted agents, but I'm not sure if we're specifying it correctly. The build never even starts."

### Technical Details
- **Trigger**: Any pipeline run
- **Error Type**: Pool/agent configuration error
- **YAML File**: `pipelines/03-pool-errors.yml`
- **Common Errors**:
  - Using `pool: name:` instead of `pool:` with `vmImage:`
  - Mixing `vmImage` and `name` in the same pool block
  - Incorrect task version numbers
  - Invalid pool syntax for Microsoft-hosted agents

### Symptoms
- Pipeline fails before any job starts
- Error messages mention "pool", "agent", or "vmImage"
- Job shows as "queued" but never runs
- "No agent found in pool" errors

### Learning Objectives
- Understand the difference between `pool: { vmImage: }` and `pool: { name: }`
- Learn when to use Microsoft-hosted vs. self-hosted agents
- Recognize task version compatibility issues
- Master pool specification at pipeline and job levels

### Key Troubleshooting Questions
1. Are you using Microsoft-hosted or self-hosted agents?
2. Is the pool syntax using `vmImage` for hosted or `name` for self-hosted?
3. Are you mixing incompatible pool properties?
4. Do you have access to the specified agent pool?
5. Are task versions compatible with the agent OS?

---

## Case #04: Variable Expression and Scoping Errors

### Customer Information
- **Organization**: `https://dev.azure.com/mcapdevopsorg`
- **Project**: `ADO_Training_STUDENT_TWO`
- **Pipeline Name**: `04-variable-errors`
- **Severity**: Medium
- **Category**: Variables / Expressions

### Problem Description (Customer's Words)
> "I'm having trouble with variables in my pipeline. I've defined some variables at the top, but when I try to use them in job conditions or scripts, they either don't work or show up as literal strings. I also tried using an `if()` function in my variables section like I saw in some PowerShell code, but Azure DevOps says it doesn't recognize it. How do I properly use variables and conditional logic in YAML pipelines?"

### Technical Details
- **Trigger**: Any pipeline run
- **Error Type**: Variable syntax and expression errors
- **YAML File**: `pipelines/04-variable-errors.yml`
- **Common Errors**:
  - Using `$( )` runtime syntax for compile-time expressions
  - Using invalid `if()` function in variable definitions
  - Incorrect boolean string comparison (`'true'` vs `true`)
  - Misunderstanding variable evaluation timing

### Symptoms
- Variables evaluate to empty or literal strings
- Conditions always evaluate to true/false regardless of actual values
- Validation errors about unrecognized functions
- Jobs skip unexpectedly or run when they shouldn't

### Learning Objectives
- Understand `$[ ]` (compile-time) vs `$( )` (runtime) expression syntax
- Learn when variables are evaluated (compile vs runtime)
- Master boolean comparisons in conditions
- Recognize invalid function usage in YAML
- Understand variable scoping across jobs

### Key Troubleshooting Questions
1. Are you using the correct expression syntax (`$[ ]` vs `$( )`)?
2. When does this variable need to be evaluated (compile-time or runtime)?
3. Are you comparing booleans correctly (`true` vs `'true'`)?
4. Is the function you're using valid in Azure Pipelines YAML?
5. Is the variable defined in the correct scope for where you're using it?

---

## Case #05: Task Configuration and Dependency Errors

### Customer Information
- **Organization**: `https://dev.azure.com/mcapdevopsorg`
- **Project**: `ADO_Training_STUDENT_THREE`
- **Pipeline Name**: `05-task-errors`
- **Severity**: High
- **Category**: Task Configuration / Dependencies

### Problem Description (Customer's Words)
> "My pipeline is failing during the build and deploy stages. The .NET build task complains about missing inputs, and the deployment job fails saying it can't find the build artifacts. I also tried to add an Azure Web App deployment, but it's asking for a service connection that I don't have set up. Is there a way to skip tasks or simulate deployments for testing? I just want to validate the pipeline structure works."

### Technical Details
- **Trigger**: Any pipeline run
- **Error Type**: Task input errors, missing dependencies, service connection issues
- **YAML File**: `pipelines/05-task-errors.yml`
- **Common Errors**:
  - Missing required task inputs (e.g., `projects` in DotNetCoreCLI@2)
  - Job dependencies not declared (`dependsOn` missing)
  - Missing service connections for Azure tasks
  - Attempting to use artifacts from jobs without dependencies

### Symptoms
- Tasks fail with "required input not supplied" errors
- Deployment jobs can't find build outputs
- Azure tasks fail with service connection errors
- Jobs run in wrong order or in parallel when they shouldn't

### Learning Objectives
- Identify required vs optional task inputs
- Understand job dependencies and execution order
- Learn artifact sharing between jobs
- Recognize when service connections are needed
- Practice creating simulation scripts for complex tasks

### Key Troubleshooting Questions
1. Have you specified all required inputs for each task?
2. Are job dependencies (`dependsOn`) properly declared?
3. Do you need artifacts from a previous job?
4. Does the Azure task require a service connection?
5. Can you simulate or stub out tasks that need external dependencies?

---

## Case #06: Trigger Syntax and Schedule Errors

### Customer Information
- **Organization**: `https://dev.azure.com/mcapdevopsorg`
- **Project**: `ADO_Training_STUDENT_THREE`
- **Pipeline Name**: `06-trigger-syntax-errors`
- **Severity**: Medium
- **Category**: Triggers / CI/CD Configuration

### Problem Description (Customer's Words)
> "I set up triggers for our pipeline, but they're not working as expected. I want it to run on commits to 'main' and 'develop', and also for pull requests to 'feature/*' branches. I also added a schedule to run nightly, but I'm getting validation errors about conflicting branch filters. The pipeline runs manually, but automated triggers aren't firing. What's the correct way to configure triggers and schedules?"

### Technical Details
- **Trigger**: Commit push or PR creation
- **Error Type**: Trigger syntax errors, schedule conflicts
- **YAML File**: `pipelines/06-trigger-syntax-errors.yml`
- **Common Errors**:
  - Using simple list syntax for triggers instead of `branches:` block
  - Mixing list and mapping syntax in PR triggers
  - Including and excluding the same branch in schedules
  - Invalid schedule cron syntax

### Symptoms
- Pipeline doesn't trigger on commits/PRs
- Validation errors mentioning "include" and "exclude"
- Scheduled runs don't execute
- Triggers fire on wrong branches

### Learning Objectives
- Master CI trigger syntax (`trigger:` with `branches:` block)
- Understand PR trigger configuration
- Learn schedule syntax and cron expressions
- Recognize branch pattern matching rules
- Avoid conflicting include/exclude filters

### Key Troubleshooting Questions
1. Are you using `branches:` blocks for complex trigger configurations?
2. Are include and exclude filters conflicting?
3. Is the schedule cron expression valid?
4. Are branch patterns using wildcards correctly?
5. Have you tested triggers with actual commits/PRs?

---

## Case #07: Job Conditions and Dependency Logic Errors

### Customer Information
- **Organization**: `https://dev.azure.com/mcapdevopsorg`
- **Project**: `ADO_Training_STUDENT_FOUR`
- **Pipeline Name**: `07-job-conditions-errors`
- **Severity**: Medium
- **Category**: Job Logic / Conditions

### Problem Description (Customer's Words)
> "We have a multi-job pipeline where some jobs should only run on the main branch, and others should run on feature branches. We also have a deployment job that should only run if the build succeeds. However, jobs are either always running, never running, or running in the wrong scenarios. I think our `condition:` statements are wrong, and I'm not sure we're referencing the right job names in `dependsOn`. How do I set up conditional job execution correctly?"

### Technical Details
- **Trigger**: Any pipeline run
- **Error Type**: Condition logic errors, dependency reference errors
- **YAML File**: `pipelines/07-job-conditions-errors.yml`
- **Common Errors**:
  - Using string `'true'` instead of boolean `true` in comparisons
  - Incorrect `dependsOn` job name references
  - Using `$( )` runtime syntax for branch comparisons in conditions
  - Invalid `and()` usage (requires multiple conditions)

### Symptoms
- Jobs run on wrong branches
- Deployment jobs run even when builds fail
- Jobs skip unexpectedly
- Dependency errors referencing non-existent jobs

### Learning Objectives
- Master conditional job execution with `condition:`
- Understand job dependencies and execution order
- Learn branch-based conditional logic
- Use `succeeded()`, `failed()`, and `always()` functions correctly
- Debug job dependency chains

### Key Troubleshooting Questions
1. Are job names in `dependsOn` matching actual job names?
2. Are you comparing variables correctly in conditions?
3. Do you need compile-time (`$[ ]`) or runtime (`$( )`) expressions?
4. Are boolean values unquoted (`true` not `'true'`)?
5. Does the condition logic match your intended behavior?

---

## Case #08: Environment Deployment Configuration Errors

### Customer Information
- **Organization**: `https://dev.azure.com/mcapdevopsorg`
- **Project**: `ADO_Training_STUDENT_FOUR`
- **Pipeline Name**: `09-environment-deployment-errors`
- **Severity**: High
- **Category**: Environments / Multi-Stage Deployment

### Problem Description (Customer's Words)
> "I'm trying to set up a multi-stage deployment pipeline that goes through Dev, Staging, and Production environments. However, the pipeline isn't tracking deployments in the Environments page, and stages are running out of order or in parallel. I also can't figure out how to add approval gates before production. The artifacts from the build stage aren't being found in the deployment stages either. Is there a special job type for deployments? How do I properly reference environments and ensure stages run in sequence?"

### Technical Details
- **Trigger**: Any pipeline run
- **Error Type**: Environment configuration errors, stage dependencies, deployment job syntax
- **YAML File**: `pipelines/09-environment-deployment-errors.yml`
- **Common Errors**:
  - Using regular `job:` instead of `deployment:` job type
  - Missing environment references (`environment:` property)
  - Incorrect or missing stage dependencies (`dependsOn`)
  - Not downloading artifacts in deployment stages
  - Missing deployment strategy (`strategy: runOnce:`)
  - No environment-specific variables or configuration

### Symptoms
- Deployments don't show in Environments page
- Can't add approval gates or checks to environments
- Stages run in parallel instead of sequentially
- Deployment stages fail with "artifact not found" errors
- No deployment history or tracking available
- Environment variables not isolated per stage

### Learning Objectives
- Understand `deployment:` job type vs regular jobs
- Learn to reference environments for tracking and approvals
- Master stage dependencies and execution order
- Configure deployment strategies (runOnce, rolling, canary)
- Manage environment-specific variables and secrets
- Download and use artifacts across stages
- Set up approval gates and checks on environments

### Key Troubleshooting Questions
1. Are you using `deployment:` job type (not regular `job:`) for deployments?
2. Is each deployment job referencing an environment with `environment:`?
3. Do stage dependencies (`dependsOn:`) form the correct deployment chain?
4. Are you downloading build artifacts in each deployment stage?
5. Is the deployment strategy specified (`strategy: runOnce:`)?
6. Have you created the environments in Azure DevOps?
7. Are environment-specific variables defined for each stage?
8. Do you need approval checks before certain environments (Production)?

---

## 🎯 Training Exercise Flow

### For Each Case:
1. **Read the customer description** - Understand the problem from their perspective
2. **Review technical details** - Identify error types and symptoms
3. **Access the pipeline** - Navigate to the specific project and pipeline
4. **Reproduce the error** - Run the pipeline and observe the failure
5. **Analyze the YAML** - Open the YAML file and identify issues
6. **Apply fixes** - Correct the errors one by one
7. **Test and verify** - Run the pipeline successfully
8. **Document learnings** - Note key takeaways and troubleshooting tips

### Success Criteria:
- Pipeline runs without errors
- All jobs complete successfully
- Understand why each fix was necessary
- Can explain the issue to others

---

## 📚 Additional Resources

- [Azure Pipelines YAML Schema Reference](https://docs.microsoft.com/azure/devops/pipelines/yaml-schema)
- [Expression Syntax Documentation](https://docs.microsoft.com/azure/devops/pipelines/process/expressions)
- [Task Reference](https://docs.microsoft.com/azure/devops/pipelines/tasks/)
- [Troubleshooting Guide](https://docs.microsoft.com/azure/devops/pipelines/troubleshooting/)

---

**Note**: These cases are designed for hands-on learning. Each student should work through cases independently, consulting documentation and using troubleshooting skills to resolve issues.
