# TLS Certificate Expiry

**Severity:** SEV-3 (SEV-1 if expired)  
**Last Updated:** 2026-01-20  
**Owner:** Platform Engineering  
**Review Cadence:** Monthly

## Symptoms

- Alert: `TLSCertExpiringSoon` fires 30 days before expiry
- Alert: `TLSCertExpired` fires on expiry (auto-escalates to SEV-1)
- Users see browser certificate warnings or connection failures
- Internal services fail mutual TLS handshakes

## Impact

- External: Users cannot access HTTPS endpoints
- Internal: Service-to-service communication fails if mTLS enforced
- Compliance: May violate security SLAs

## Triage Checklist

1. [ ] Identify which certificate is expiring: `kubectl get certificates -A | grep -v True`
2. [ ] Check cert details: `openssl s_client -connect <host>:443 -servername <host> 2>/dev/null | openssl x509 -noout -dates`
3. [ ] Verify cert-manager is running: `kubectl get pods -n cert-manager`
4. [ ] Check cert-manager logs: `kubectl logs -n cert-manager deployment/cert-manager --tail=50`

## Mitigation

1. [ ] If cert-manager is healthy, trigger renewal: `kubectl delete certificate <cert-name> -n <namespace>` (cert-manager will recreate)
2. [ ] If cert-manager is down, restart it: `kubectl rollout restart deployment/cert-manager -n cert-manager`
3. [ ] Manual renewal if automated fails: Follow manual cert rotation docs

## Resolution

1. [ ] Verify new certificate is issued: `kubectl get certificate <name> -n <namespace> -o yaml | grep -A5 status`
2. [ ] Confirm services picked up new cert (may require pod restart)
3. [ ] Investigate why auto-renewal failed and fix root cause

## Escalation

- **Escalate to Platform Engineering** if: cert-manager cannot issue certificates
- **Page Security On-Call** if: Certificate has expired in production
- **Incident Commander** if: External-facing services affected

## Post-Incident

- [ ] Create post-incident review ticket
- [ ] Update cert-manager configuration if needed
- [ ] Verify monitoring covers all certificates

## References

- Certificate dashboard: https://grafana.internal/d/tls-certs
- cert-manager docs: https://wiki.internal/platform/cert-management
- Manual rotation: https://wiki.internal/platform/manual-cert-rotation
