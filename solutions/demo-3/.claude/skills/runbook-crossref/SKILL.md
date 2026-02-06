---
name: runbook-crossref
description: Use this skill when creating new incident runbooks to cross-reference against existing runbooks. Triggers whenever a new runbook is being generated. This skill should be used alongside the runbook-generator skill to ensure new runbooks don't duplicate existing content and include links to related procedures.
---

# Runbook Cross-Reference & Deduplication

## Overview

Before generating a new runbook, scan existing runbooks to check for duplicates and identify related procedures. This prevents runbook sprawl and ensures the team's documentation stays interconnected.

## Instructions

When a new runbook is requested:

### Step 1: Scan Existing Runbooks

1. Read all `.md` files in the `sample-runbooks/` directory (or the project's runbook directory)
2. For each existing runbook, extract:
   - Title (the H1 heading)
   - Severity level
   - Symptoms section content
   - Services mentioned

### Step 2: Check for Duplicates

Compare the requested incident against existing runbooks:

- **Exact match**: If a runbook already exists for this exact incident type, inform the user and offer to update the existing runbook instead of creating a new one
- **Near match**: If a runbook covers a very similar incident (e.g., "high CPU on API servers" vs "high CPU on worker nodes"), flag this and ask whether to create a new runbook or extend the existing one

Matching criteria:
- Same service name AND same symptom type = likely duplicate
- Same symptom type but different service = related, not duplicate
- Same service but different symptom type = related, not duplicate

### Step 3: Identify Related Runbooks

Find runbooks that are related but not duplicates. A runbook is "related" if:
- It affects the same service or service family
- It has overlapping symptoms (e.g., high memory and OOM kills)
- It's part of the same failure chain (e.g., connection pool exhaustion → database timeout)
- Its mitigation or escalation paths overlap

### Step 4: Generate the Runbook

Use the **runbook-generator** skill to produce the actual runbook content. Follow all formatting and structural requirements defined in that skill.

### Step 5: Append Cross-References

After the standard runbook template, enhance the **References** section with:

```markdown
## References

- Relevant dashboards: [links]
- Architecture docs: [links]

### Related Runbooks

| Runbook | Relationship | Why It's Related |
|---------|-------------|-----------------|
| [Title](path) | Same Service / Similar Symptoms / Failure Chain | Brief explanation |
```

Also add a note at the top of the new runbook if near-duplicates were found:

```markdown
> **Note:** A related runbook exists: [Title](path). Review before using this procedure.
```

## Output

- If duplicate found: Message explaining the duplicate, offer to update existing
- If no duplicate: New runbook with cross-references appended
- Always: List of related runbooks identified during the scan
