---
name: runbook-generator
description: Use this skill when the user asks to create, generate, or write an incident runbook, playbook, or response procedure. Triggers on alert names, incident descriptions, or requests containing words like "runbook", "playbook", "incident response", "on-call procedure", or "troubleshooting guide". Also triggers when given a monitoring alert and asked to document the response.
---

# Incident Runbook Generator

## Overview

Generate structured, actionable incident runbooks that follow the team's standard format. Every runbook produced by this skill will be consistent in structure, tone, and level of detail — making them reliable under pressure at 3 AM.

## Instructions

When asked to generate a runbook:

1. **Identify the incident type** from the user's description (e.g., "high CPU", "connection pool exhaustion", "certificate expiry")
2. **Classify severity** using the definitions below
3. **Generate the runbook** following the exact template structure
4. **Output as a markdown file** named `runbook-<incident-slug>.md` (e.g., `runbook-high-cpu-api-servers.md`)

## Runbook Template

Every runbook MUST contain these sections in this exact order:

```markdown
# [Incident Title]

**Severity:** [SEV-1 | SEV-2 | SEV-3 | SEV-4]  
**Last Updated:** [date]  
**Owner:** [team name — leave as TBD if unknown]  
**Review Cadence:** Quarterly

## Symptoms

What does this incident look like? List the observable indicators.
- Alert name and threshold
- User-facing impact
- Dashboard signals

## Impact

Who and what is affected?
- Services impacted
- User population affected
- Business impact (revenue, SLA, compliance)

## Triage Checklist

Step-by-step diagnostic procedure. Each step should be a command or action.
1. [ ] First thing to check (include exact command)
2. [ ] Second thing to check
3. [ ] Third thing to check

## Mitigation

Immediate actions to reduce impact. NOT root cause fixes.
1. [ ] First mitigation step (include exact command)
2. [ ] Second mitigation step
3. [ ] Rollback procedure if applicable

## Resolution

Steps to fully resolve the underlying issue.
1. [ ] Resolution step with commands
2. [ ] Verification that the fix worked

## Escalation

When and how to escalate.
- **Escalate to [team]** if: [condition]
- **Page [role]** if: [condition]
- **Incident commander** if: SEV-1 or customer-facing for > [duration]

## Post-Incident

- [ ] Create post-incident review ticket
- [ ] Update this runbook if procedure changed
- [ ] Notify stakeholders via [channel]

## References

- Relevant dashboards: [links]
- Related runbooks: [links]
- Architecture docs: [links]
```

## Severity Definitions

| Level | Definition | Response Time | Examples |
|-------|-----------|---------------|---------|
| **SEV-1** | Complete service outage or data loss risk | Immediate, all-hands | Full production down, data corruption, security breach |
| **SEV-2** | Major feature degraded, significant user impact | < 30 minutes | Partial outage, severe latency, payment failures |
| **SEV-3** | Minor feature degraded, limited user impact | < 2 hours | Single endpoint slow, non-critical service down |
| **SEV-4** | Cosmetic or minimal impact | Next business day | Log noise, minor UI glitch, non-user-facing |

## Style Guide

- **Tone**: Terse, direct, action-oriented. No filler. No "you might want to consider..."
- **Commands**: Always include exact CLI commands, not just descriptions. Use code blocks.
- **Checklists**: Use `[ ]` checkboxes so responders can track progress
- **Assumptions**: Assume the reader is an on-call engineer at 3 AM who has never seen this alert before
- **Specificity**: Prefer `kubectl get pods -n production | grep CrashLoop` over "check the pods"
- **Time estimates**: Include expected duration for each section where applicable
