# Demo 2: Simple Runbook Generator

## Goal

Build a Skill that generates structured incident runbooks from alert descriptions, following your team's conventions every time.

## The Problem

Without a Skill, every time you ask Claude to write a runbook you get a different format. Different sections, different levels of detail, different tone. Your team ends up with inconsistent documentation that's hard to use under pressure.

**With a Skill**, Claude follows your team's runbook template every single time.

## Hands-On: Build the Runbook Generator

1. Open the skill file at `.claude/skills/runbook-generator/SKILL.md` — it's currently empty.

2. Write the skill. Here's what it needs to encode:

   - **When to trigger**: Alert names, incident descriptions, runbook requests
   - **Required sections**: Every runbook must have the same structure
   - **Severity classification**: Your team's severity definitions
   - **Tone & style**: Terse, action-oriented, no fluff

3. A scaffold to get you started (fill in the details):

```markdown
---
name: runbook-generator
description: [YOUR TRIGGER DESCRIPTION HERE]
---

# Incident Runbook Generator

## Overview
[What does this skill do?]

## Instructions
[Step-by-step process Claude should follow]

## Runbook Template
[The exact structure every runbook should follow]

## Severity Definitions
[Your team's severity levels]

## Style Guide
[Tone, voice, formatting rules]
```

4. Test it:

```bash
claude "Generate a runbook for: High CPU usage on production API servers exceeding 90% for more than 5 minutes"
```

5. Test it again with a different alert:

```bash
claude "Create an incident runbook for: Database connection pool exhaustion on the orders service"
```

Both outputs should follow the **exact same structure**.

## Tips

- Be specific about section order — Claude follows what you write
- Include an example in your Skill if you want a particular style
- The `description` field is how Claude knows to use this skill — make it match your real workflow language

## Check Your Work

Compare your output against [solutions/demo-2/](../solutions/demo-2/) if you get stuck.

## Next: [Demo 3 →](../demo-3-multi-skill/)
