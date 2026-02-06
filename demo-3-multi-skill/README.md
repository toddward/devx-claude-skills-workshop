# Demo 3: Multi-Skill Orchestration

## Goal

Chain the runbook generator with a cross-reference skill that checks existing runbooks for overlap, links related procedures, and prevents duplication.

## The Concept

Skills can reference other skills. When Skill B says "use the runbook-generator skill" in its instructions, Claude will read and follow both skills' instructions in a single interaction.

This is powerful because:
- Each skill stays focused on one responsibility
- Skills are reusable across different compositions
- You can mix and match skills without rewriting anything

## How It Works

```
User: "Create a runbook for Redis connection timeouts"
  │
  ▼
┌─────────────────────┐
│  runbook-crossref    │  ← Skill B: orchestrator
│                      │
│  1. Scan existing    │
│     runbooks in      │
│     sample-runbooks/ │
│  2. Check for        │
│     duplicates       │
│  3. Identify related │
│     procedures       │
│  4. Invoke runbook-  │
│     generator skill  │
│  5. Add cross-refs   │
│     to output        │
└─────────┬───────────┘
          │ references
          ▼
┌─────────────────────┐
│  runbook-generator   │  ← Skill A: the generator from Demo 2
│                      │
│  Generates the       │
│  structured runbook  │
│  per team standards  │
└─────────────────────┘
```

## Hands-On: Build the Cross-Reference Skill

The `runbook-generator` skill is already in place (copied from Demo 2's solution). You need to build the `runbook-crossref` skill.

1. Open `.claude/skills/runbook-crossref/SKILL.md` — it's currently empty.

2. This skill needs to:
   - **Scan** the `sample-runbooks/` directory for existing runbooks
   - **Compare** the new request against existing runbook titles and symptoms
   - **Flag** if a similar runbook already exists
   - **Delegate** to the `runbook-generator` skill for the actual generation
   - **Append** a "Related Runbooks" section with links to similar procedures

3. Key instruction to include — this is how you reference another skill:

```markdown
## Generation

After cross-referencing, use the **runbook-generator** skill to produce the 
actual runbook. Follow all formatting and structural requirements from that skill.
```

4. Test it:

```bash
claude "Create a runbook for: Redis connection timeouts causing 503 errors on the user service"
```

Claude should scan the sample runbooks, note any related ones, generate using the runbook-generator format, and include cross-references.

## Sample Runbooks

The `sample-runbooks/` directory contains existing runbooks that the cross-reference skill should check against. In a real environment, this would be your team's actual runbook directory.

## Check Your Work

Compare your output against [solutions/demo-3/](../solutions/demo-3/) if you get stuck.

## Next: [Demo 4 →](../demo-4-hooks/)
