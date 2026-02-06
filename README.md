# Building Claude Skills: Teaching Claude Your Team's Way

**DevX Working Group | February 2026**

A hands-on workshop for building Claude Skills — custom instruction sets that teach Claude specialized workflows, domain knowledge, and best practices specific to your environment.

## What You'll Build

We'll progressively build an **Incident Runbook system** using Claude Skills:

| Demo | What You'll Build | Concept |
|------|-------------------|---------|
| **Demo 1** | Setup & Configuration | Directory structure, SKILL.md anatomy, installation |
| **Demo 2** | Runbook Generator | A simple skill that generates structured incident runbooks |
| **Demo 3** | Multi-Skill Orchestration | Chain the generator with a cross-reference skill |
| **Demo 4** | Hook-Triggered Validation | Auto-validate runbooks when files change |

## Prerequisites

- **Claude Code** installed and running (`claude --version`)
- Familiarity with MCP concepts (or attended the January session)
- A terminal and text editor
- This repo cloned locally

```bash
git clone https://github.com/toddward/devx-claude-skills-workshop.git
cd devx-claude-skills-workshop
```

## Skills vs MCPs vs Agents — The Quick Version

| | Skills | MCPs | Agents |
|---|--------|------|--------|
| **What** | Instructions & workflows | Tool & data connections | Autonomous task execution |
| **Analogy** | A playbook / runbook | A power adapter / API | A team member |
| **Lives in** | `.claude/skills/` | `.claude/settings.json` | Claude Code / orchestration |
| **Example** | "Generate runbooks in *this* format" | "Connect to PagerDuty API" | "Triage this incident end-to-end" |

**Rule of thumb:** You wouldn't build an MCP server just to enforce your naming conventions — that's a Skill. You wouldn't write a Skill to query Jira — that's an MCP.

## Workshop Flow

### Demo 1: Setup & Configuration → [demo-1-setup/](demo-1-setup/)

Learn where Skills live, how they're structured, and how Claude discovers them.

### Demo 2: Simple Runbook Generator → [demo-2-runbook-generator/](demo-2-runbook-generator/)

Build a Skill that generates structured incident runbooks from alert descriptions.

### Demo 3: Multi-Skill Orchestration → [demo-3-multi-skill/](demo-3-multi-skill/)

Chain the runbook generator with a cross-reference skill that checks for duplicates and links related procedures.

### Demo 4: Hook-Triggered Validation → [demo-4-hooks/](demo-4-hooks/)

Set up a hook that automatically validates runbooks against team standards whenever they're created or modified.

## Solutions

Stuck? Completed versions of each demo are in [solutions/](solutions/).

## After the Workshop

- Drop your Skills into any project's `.claude/skills/` directory
- Share team Skills via your org's repos
- Combine Skills + MCPs + Hooks for powerful automation chains
