# Demo 4: Hook-Triggered Validation

## Goal

Set up a hook that automatically validates runbooks against team standards whenever Claude creates or modifies a runbook file.

## What Are Hooks?

Hooks are event-driven triggers that automatically invoke behavior based on Claude's actions. They're defined in `.claude/hooks/` and fire when specific conditions are met.

Think of hooks like git hooks, but for Claude's actions:

| Hook Type | Fires When | Use Case |
|-----------|-----------|----------|
| `PreToolUse` | Before Claude uses a tool | Validate, gate, or modify tool inputs |
| `PostToolUse` | After Claude uses a tool | Check outputs, enforce standards |
| `Notification` | On specific events | Alert, log, or trigger side effects |

## How Hooks + Skills Work Together

```
Claude creates a file: runbook-redis-timeout.md
  │
  ▼
┌─────────────────────────────┐
│  PostToolUse Hook            │  ← Fires after file creation
│  Matches: write_to_file      │
│  Pattern: **/runbook-*.md    │
│                              │
│  Invokes validation skill    │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│  runbook-validator skill     │  ← Checks the file
│                              │
│  - All required sections?    │
│  - Severity classified?      │
│  - Commands in code blocks?  │
│  - Checklists present?       │
└─────────────────────────────┘
```

## Hands-On: Build the Validator

### Part A: Create the Validation Skill

Open `.claude/skills/runbook-validator/SKILL.md` and build a skill that:

- Reads a runbook file
- Checks it against the required template sections
- Validates formatting rules (code blocks for commands, checkboxes for checklists)
- Reports what's missing or non-compliant

### Part B: Create the Hook

Hooks are configured in `.claude/hooks/`. Create a hook configuration that:

- Triggers after file creation/modification
- Matches runbook file patterns (`runbook-*.md`)
- Invokes the validation skill

The hook configuration goes in `.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "write_to_file|create_file",
        "hook": ".claude/hooks/validate-runbook.sh"
      }
    ]
  }
}
```

And the hook script `.claude/hooks/validate-runbook.sh` checks if the file matches the pattern and runs validation.

### Test It

```bash
claude "Create a runbook for: Kafka consumer lag exceeding 10,000 messages on the notifications service"
```

After Claude generates the runbook, the hook should automatically fire and validate the output.

## Check Your Work

Compare against [solutions/demo-4/](../solutions/demo-4/) if you get stuck.

## Recap

You've now built a complete system:

1. **Skill** that generates consistent runbooks (Demo 2)
2. **Multi-skill** that cross-references before generating (Demo 3)  
3. **Hook** that validates output automatically (Demo 4)

This is the pattern: **Skills encode knowledge → Composition chains workflows → Hooks enforce standards**.
