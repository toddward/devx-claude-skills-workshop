# Demo 1: Setup & Configuration

## Goal

Understand where Skills live, how they're structured, and how Claude discovers them.

## Skill Directory Structure

Claude looks for Skills in two locations:

```
# Project-level skills (shared via git, team-specific)
your-project/
└── .claude/
    └── skills/
        └── my-skill/
            └── SKILL.md         # The skill definition

# User-level skills (personal, available everywhere)
~/.claude/
└── skills/
    └── my-personal-skill/
        └── SKILL.md
```

**Project skills** live in `.claude/skills/` inside your repo. These are version-controlled and shared with your team.

**User skills** live in `~/.claude/skills/` and are available in every project you work on.

## Anatomy of a SKILL.md

Every skill starts with a `SKILL.md` file. Here's the minimal structure:

```markdown
---
name: my-skill
description: A brief description of what this skill does and when to trigger it.
---

# My Skill Name

## Overview
What this skill does and why it exists.

## Instructions
Step-by-step instructions Claude should follow when this skill is triggered.

## Output Format
What the output should look like.
```

### The Frontmatter

The `---` block at the top is YAML frontmatter:

- **name**: Machine-readable identifier (lowercase, hyphens)
- **description**: This is critical — Claude uses this to decide WHEN to activate the skill. Write it like a trigger condition.

### The Body

The markdown body contains the actual instructions. Think of it as writing a detailed runbook for a very capable but literal-minded colleague.

## Hands-On: Create Your First Skill

1. Create the directory structure:

```bash
cd demo-1-setup
mkdir -p .claude/skills/hello-world
```

2. Create `.claude/skills/hello-world/SKILL.md`:

```markdown
---
name: hello-world
description: Use this skill when the user asks to create a greeting or welcome message. Triggers on words like "hello", "welcome", "greet".
---

# Hello World Skill

## Overview
Generates a friendly, team-appropriate greeting message.

## Instructions
1. Ask for the recipient's name if not provided
2. Include the current date
3. Keep the tone professional but warm
4. Always sign off with "— Your DevX Team"

## Output Format
A short greeting message (2-3 sentences max) followed by the sign-off.
```

3. Test it with Claude Code:

```bash
claude "Create a welcome message for Sarah who just joined the platform team"
```

Claude should pick up your skill and follow the format you defined.

## Key Takeaways

- Skills are just markdown files in a known directory
- The `description` field controls when Claude activates the skill
- Project skills (`.claude/skills/`) are shared; user skills (`~/.claude/skills/`) are personal
- No code required — Skills are pure instructions

## Next: [Demo 2 →](../demo-2-runbook-generator/)
