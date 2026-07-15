# Incident Report

## Executive Summary

A simulated security incident was conducted to demonstrate the complete lifecycle of a Linux host compromise and the corresponding incident response process.

The attacker successfully obtained access to the system through an SSH password brute-force attack against a valid user account. After authentication, a misconfigured `sudo` permission allowed privilege escalation to root through an abused GTFOBins binary. The attacker then established persistence using a cron job and simulated the exfiltration of a sensitive archive.

Following the compromise, the incident was investigated using host logs, process information, network captures, and scheduled task analysis. The attacker was contained, persistence was removed, and the system was verified to have returned to a trusted state.

---

# Incident Details

| Item | Value |
|------|-------|
| Incident Type | Unauthorized Access / Privilege Escalation |
| Operating System | Kali Linux |
| Initial Access | SSH Password Brute Force |
| Compromised Account | `auditor` |
| Highest Privilege Obtained | Root |
| Persistence | Cron Job |
| Data Access | `/root/sensitive-data.7z` |
| Exfiltration | Simulated using Netcat |
| Severity | Critical |
| Confidence | High |

---

# Attack Summary

The attack followed the sequence below:

1. Network reconnaissance identified the SSH service.
2. Hydra successfully recovered valid SSH credentials.
3. The attacker authenticated as the `auditor` user.
4. A misconfigured `sudo` permission allowed execution of `ssh-agent` as root.
5. Root access was obtained using a GTFOBins technique.
6. Sensitive files were accessed and transferred to the attacker.
7. Persistence was established through a scheduled cron task.

---

# Evidence Collected

The investigation used the following evidence sources:

- SSH authentication logs (`journalctl`)
- Process listings
- Open network connections
- Cron configuration
- Packet captures
- Wireshark analysis
- Suricata alerts
- IOC documentation

These artifacts allowed the complete attack timeline to be reconstructed.

---

# Incident Response

## Detection

The compromise was identified through abnormal SSH authentication activity, suspicious process execution, and network traffic associated with the attack.

## Containment

Response actions included:

- Terminating attacker sessions
- Locking the compromised user account
- Removing the malicious cron entry
- Blocking attacker communication
- Verifying that malicious processes were no longer active

## Eradication

Remaining persistence mechanisms and attacker artifacts were removed. System processes, scheduled tasks, and network activity were reviewed to confirm the compromise had been eliminated.

## Recovery

The system was validated to ensure:

- Services were operating normally.
- No unauthorized persistence remained.
- Network connections were expected.
- Authentication systems functioned correctly.

---

# Indicators of Compromise

Key indicators identified during the investigation included:

- SSH brute-force activity
- Compromised `auditor` account
- Abuse of `/usr/bin/ssh-agent`
- Cron-based reverse shell persistence
- Netcat communication on TCP port 12345
- Access to `sensitive-data.7z`

---

# MITRE ATT&CK Summary

| Tactic | Technique |
|---------|-----------|
| Reconnaissance | Network Service Scanning (T1046) |
| Initial Access | Brute Force (T1110.001) |
| Initial Access | Valid Accounts (T1078) |
| Privilege Escalation | Abuse Elevation Control Mechanism (T1548) |
| Persistence | Scheduled Task/Job: Cron (T1053.003) |
| Collection | Data from Local System (T1005) |
| Exfiltration | Exfiltration Over C2 Channel (T1041) |

---

# Lessons Learned

This investigation demonstrated the importance of correlating host-based and network-based evidence during incident response.

Several opportunities for improvement were identified:

- Deploy additional host telemetry such as auditd or Sysmon for Linux.
- Centralize log collection using a SIEM platform.
- Implement account lockout policies to reduce the effectiveness of password guessing attacks.
- Expand detection coverage through additional Sigma and Suricata rules.
- Continue improving visibility into privilege escalation and persistence techniques.

Although performed in a home lab, the methodology used throughout this case study closely mirrors the workflow followed during real-world incident response investigations, from initial detection through recovery and post-incident analysis.