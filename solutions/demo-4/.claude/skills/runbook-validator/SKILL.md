---
name: runbook-validator
description: Use this skill to validate incident runbooks against team standards. Triggers when asked to review, validate, check, or audit a runbook file. Also triggered automatically by the post-write hook when a runbook file is created or modified.
---

# Runbook Validator

## Overview

Validate incident runbooks against the team's required structure and formatting standards. Reports compliance issues and optionally auto-fixes them.

## Instructions

When given a runbook file to validate:

### Step 1: Read the File

Read the entire runbook markdown file.

### Step 2: Check Required Sections

Every runbook MUST contain these sections. Report any that are missing:

| Section | Required | Check |
|---------|----------|-------|
| H1 Title | ✅ | Must be the first line |
| Metadata block | ✅ | Severity, Last Updated, Owner, Review Cadence |
| Symptoms | ✅ | Must contain at least one bullet or paragraph |
| Impact | ✅ | Must describe who/what is affected |
| Triage Checklist | ✅ | Must contain checkbox items `[ ]` |
| Mitigation | ✅ | Must contain actionable steps |
| Resolution | ✅ | Must contain fix steps |
| Escalation | ✅ | Must contain at least one escalation path |
| Post-Incident | ✅ | Must contain post-incident checklist |
| References | ✅ | Must contain at least one link |

### Step 3: Check Formatting Rules

| Rule | How to Check |
|------|-------------|
| Commands in code blocks | Any CLI command must be in a `` ` `` or ``` block |
| Checklists use checkboxes | Triage, Mitigation, Resolution use `[ ]` not `-` or `*` |
| Severity is valid | Must be one of: SEV-1, SEV-2, SEV-3, SEV-4 |
| No empty sections | Every section must have content |
| Terse tone | Flag any sentences starting with "You might want to" or "Consider" — should be direct imperatives |
| Specific commands | Flag vague instructions like "check the pods" without a specific command |

### Step 4: Report Results

Output a validation report in this format:

```markdown
## Runbook Validation Report

**File:** `<filename>`  
**Status:** ✅ PASS | ⚠️ WARNINGS | ❌ FAIL

### Missing Sections
- [ ] List any missing required sections

### Formatting Issues
- [ ] List any formatting violations

### Style Issues  
- [ ] List any tone/specificity problems

### Summary
X of Y required sections present. Z formatting issues found.
```

### Step 5: Offer Fixes

If issues are found, offer to fix them automatically. For missing sections, generate placeholder content that follows the template. For formatting issues, apply the fix directly.

## Severity of Findings

- **FAIL**: Missing required sections, invalid severity level, no checklist items
- **WARNING**: Vague commands, missing references, tone issues
- **PASS**: All required sections present, formatting correct, commands specific
