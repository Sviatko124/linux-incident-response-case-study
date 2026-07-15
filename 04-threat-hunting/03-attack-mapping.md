# MITRE ATT&CK Mapping

## Overview

The simulated attack was mapped against the MITRE ATT&CK framework to standardize attacker behavior and identify possible detection opportunities.

Each technique was mapped to:

- The attacker action performed
- The associated ATT&CK technique
- Available detection sources

---

# ATT&CK Technique Mapping

| Attack Action                           | MITRE ATT&CK Technique            | ID        | Detection Source    |
| --------------------------------------- | --------------------------------- | --------- | ------------------- |
| Network scanning with Nmap              | Network Service Scanning          | T1046     | PCAP, Suricata      |
| SSH password guessing                   | Brute Force: Password Guessing    | T1110.001 | SSH logs, Suricata  |
| SSH login using compromised credentials | Valid Accounts                    | T1078     | journalctl SSH logs |
| Host enumeration                        | System Information Discovery      | T1082     | Process activity    |
| Process enumeration                     | Process Discovery                 | T1057     | Process snapshots   |
| Sudo privilege escalation               | Abuse Elevation Control Mechanism | T1548     | Process logs        |
| Cron persistence                        | Scheduled Task/Job: Cron          | T1053.003 | Cron configuration  |
| Accessing sensitive archive             | Data from Local System            | T1005     | File activity       |
| Netcat data transfer                    | Exfiltration Over C2 Channel      | T1041     | PCAP, Zeek          |

---

# Attack Lifecycle Mapping

```
Reconnaissance
    |
    | T1046
    v

Initial Access
    |
    | T1110.001
    | T1078
    v

Privilege Escalation
    |
    | T1548
    v

Persistence
    |
    | T1053.003
    v

Collection
    |
    | T1005
    v

Exfiltration
    |
    | T1041
```

---

# Detection Coverage

| Technique | Visibility Available | Improvement |
|---|---|---|
| Network scanning | PCAP, Suricata | IDS tuning |
| SSH brute force | SSH logs | Account lockout policies |
| Valid accounts | journalctl | Centralized authentication monitoring |
| Privilege escalation | Limited process evidence | Deploy auditd |
| Cron persistence | Manual inspection | File integrity monitoring |
| Exfiltration | PCAP | Network anomaly detection |

---

# Summary

The ATT&CK mapping demonstrates that each stage of the simulated attack produced detectable behaviors.

The primary detection gaps identified were:

- Lack of execution telemetry
- Limited centralized logging
- No endpoint detection platform

Future improvements should focus on increasing visibility and automating detection of these techniques.