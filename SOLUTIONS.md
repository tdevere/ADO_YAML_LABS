# YAML Pipeline Troubleshooting Solutions

This document provides detailed fixes for the problem pipelines in `pipelines/`. Each solution includes the corrected YAML and explanations. Solutions are kept local (not in repo).

## Problem 1: Syntax Indentation Error (02-syntax-errors.yml)

**Issues Found:**

1. Trigger array inconsistent indentation (line 3-4)
2. Pool missing indentation (line 6)
3. Variables section missing indentation (line 9-10)
4. Task inputs not indented (line 15)

**Fixes:**

- Correct indentation for arrays and objects.
- Ensure consistent spacing.

See [`pipelines/02-syntax-errors-solution.yml`](pipelines/02-syntax-errors-solution.yml) for the full corrected YAML.

## Problem 2: Agent Pool & Image Error (03-pool-errors.yml)

**Issues Found:**

1. Deprecated image 'vs2017-win2016'
2. Pool config uses string instead of object
3. Missing testProjectPath variable

**Fixes:**

- Use `pool: name: 'Default'` for self-hosted agents.
- Add required variables.

See [`pipelines/03-pool-errors-solution.yml`](pipelines/03-pool-errors-solution.yml) for the full corrected YAML.

## Problem 3: Variable Expression Error (04-variable-errors.yml)

**Issues Found:**

1. Mixed variable syntax (template vs macro)
2. Wrong context for template syntax
3. Path doesn't exist

**Fixes:**

- Use macro syntax `$(var)` in scripts.
- Correct project paths.

See [`pipelines/04-variable-errors-solution.yml`](pipelines/04-variable-errors-solution.yml) for the full corrected YAML.

## Problem 4: Task & Dependency Error (05-task-errors.yml)

**Issues Found:**

1. Missing required 'projects' input
2. Wrong job name in dependsOn
3. Missing condition

**Fixes:**

- Add required inputs.
- Correct job dependencies and conditions.

See [`pipelines/05-task-errors-solution.yml`](pipelines/05-task-errors-solution.yml) for the full corrected YAML.

## Problem 5: Trigger & Condition Error (06-trigger-errors.yml)

**Issues Found:**

1. Conflicting triggers
2. Wrong condition syntax
3. String vs boolean comparison

**Fixes:**

- Remove conflicting triggers.
- Use correct condition syntax.

See [`pipelines/06-trigger-errors-solution.yml`](pipelines/06-trigger-errors-solution.yml) for the full corrected YAML.