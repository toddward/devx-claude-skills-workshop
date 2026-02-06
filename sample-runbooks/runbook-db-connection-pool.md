# Database Connection Pool Exhaustion

**Severity:** SEV-2  
**Last Updated:** 2026-01-10  
**Owner:** Data Infrastructure  
**Review Cadence:** Quarterly

## Symptoms

- Alert: `DBConnectionPoolExhausted` fires when available connections drop below 5%
- Application logs show `ConnectionTimeoutException` or `Unable to acquire connection`
- Downstream services return 503 errors with "service unavailable" messages

## Impact

- Orders service cannot process transactions
- User-facing APIs return errors for any database-dependent endpoints
- Cascading failures possible if retry storms begin

## Triage Checklist

1. [ ] Check connection pool metrics: `curl -s http://app:8080/actuator/metrics/hikaricp.connections.active | jq .`
2. [ ] Verify database is reachable: `pg_isready -h db-primary.internal -p 5432`
3. [ ] Check active connections on DB: `psql -h db-primary.internal -c "SELECT count(*) FROM pg_stat_activity WHERE state = 'active';"`
4. [ ] Look for long-running queries: `psql -h db-primary.internal -c "SELECT pid, now() - pg_stat_activity.query_start AS duration, query FROM pg_stat_activity WHERE state != 'idle' ORDER BY duration DESC LIMIT 5;"`
5. [ ] Check for recent config changes: `git log --oneline -5 -- config/database.yml`

## Mitigation

1. [ ] Kill long-running queries if identified: `psql -h db-primary.internal -c "SELECT pg_terminate_backend(<pid>);"`
2. [ ] Restart application to reset pool: `kubectl rollout restart deployment/orders-service -n production`
3. [ ] Temporarily increase pool size if load-related: Update `HIKARI_MAX_POOL_SIZE` env var and restart

## Resolution

1. [ ] Identify query or code path causing connection leaks
2. [ ] Fix connection handling (ensure connections are returned to pool)
3. [ ] Deploy fix and monitor connection pool metrics for 24h
4. [ ] Verify no connection leak under load test

## Escalation

- **Escalate to Data Infrastructure** if: Database itself is unresponsive
- **Page DBA On-Call** if: Replication lag exceeds 30s or primary failover needed
- **Incident Commander** if: SEV-1 or transaction processing halted

## Post-Incident

- [ ] Create post-incident review ticket
- [ ] Update this runbook if procedure changed
- [ ] Notify stakeholders via #incidents Slack channel

## References

- Connection pool dashboard: https://grafana.internal/d/db-connections
- Related: [High Memory Usage Runbook](runbook-high-memory.md)
- Architecture docs: https://wiki.internal/data/connection-pooling
