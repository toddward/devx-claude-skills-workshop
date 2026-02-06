# High Memory Usage on Application Servers

**Severity:** SEV-2  
**Last Updated:** 2025-12-15  
**Owner:** Platform Engineering  
**Review Cadence:** Quarterly

## Symptoms

- Alert: `HighMemoryUsage` fires when RSS exceeds 85% on any app server
- Users may experience slow response times or 502 errors
- Grafana dashboard shows memory climbing without plateau

## Impact

- API response times degrade above 85% memory utilization
- At 95%+, OOM killer may terminate application processes
- Affects all users on the impacted server

## Triage Checklist

1. [ ] Check which server(s) are affected: `kubectl top nodes | sort -k4 -rn | head -5`
2. [ ] Identify memory-heavy pods: `kubectl top pods -A --sort-by=memory | head -10`
3. [ ] Check for memory leaks: `kubectl logs <pod> --tail=100 | grep -i "heap\|memory\|oom"`
4. [ ] Review recent deployments: `kubectl rollout history deployment/<app> -n production`

## Mitigation

1. [ ] Restart the highest-memory pod: `kubectl delete pod <pod-name> -n production`
2. [ ] If multiple pods affected, perform rolling restart: `kubectl rollout restart deployment/<app> -n production`
3. [ ] Scale up if load-related: `kubectl scale deployment/<app> --replicas=<n+1> -n production`

## Resolution

1. [ ] Identify root cause from heap dumps or profiling
2. [ ] Apply fix and deploy via standard pipeline
3. [ ] Verify memory stabilizes over 24h monitoring window

## Escalation

- **Escalate to Platform Engineering** if: Memory doesn't drop after pod restart
- **Page SRE On-Call** if: OOM kills occurring on multiple servers
- **Incident Commander** if: SEV-1 or user-facing impact exceeds 15 minutes

## Post-Incident

- [ ] Create post-incident review ticket
- [ ] Update this runbook if procedure changed
- [ ] Notify stakeholders via #incidents Slack channel

## References

- Memory dashboard: https://grafana.internal/d/memory-overview
- Related: [High CPU Usage Runbook](runbook-high-cpu.md)
- Architecture docs: https://wiki.internal/platform/memory-management
