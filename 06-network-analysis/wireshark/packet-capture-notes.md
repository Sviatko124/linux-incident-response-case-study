# Network Analysis

## Overview

Network traffic generated during the simulated attack was captured using `tcpdump` and analyzed with Wireshark. Although the environment consists of a single virtual machine acting as both attacker and victim, the captured traffic still reflects the network behavior expected during each phase of the attack.

The objective of this analysis was to correlate observed network activity with the host-based evidence collected during the investigation and verify the progression of the attack.

---

# Reconnaissance

The first stage of the attack consisted of a TCP SYN scan performed with Nmap to identify exposed services on the target system.

### Wireshark Filter

```text
tcp.flags.syn == 1 && tcp.flags.ack == 0
```

This filter displays the initial SYN packets transmitted by the scanner. Multiple SYN packets sent to different destination ports within a short period are characteristic of reconnaissance activity.

**Screenshot:**
![[nmap_screenshot.png]]

---

# SSH Brute Force

Following reconnaissance, Hydra was used to perform a password guessing attack against the SSH service.

Since SSH traffic is encrypted, the authentication attempts cannot be viewed directly. Instead, the packet capture shows a rapid sequence of TCP connections to port 22, indicating repeated login attempts.

### Wireshark Filter

```text
tcp.port == 22
```

The large number of short-lived SSH connections observed in a short time window is consistent with automated credential attacks.

**Screenshot:**
![[ssh_screenshot.png]]

---

# Correlation with Host Evidence

The packet captures support the findings from the host investigation:

| Network Observation | Host Evidence | Conclusion |
|---------------------|---------------|------------|
| Multiple TCP SYN packets | Nmap execution | Network reconnaissance |
| Repeated SSH connections | `ssh.log` | SSH brute-force attack |
| Successful SSH session | `journalctl` | Initial access obtained |

While the encrypted SSH payload prevents inspection of the commands executed after authentication, correlating the packet captures with system logs provides a complete picture of the attack lifecycle.

---

# Conclusion

The network analysis confirms the sequence of events observed throughout the investigation. Packet captures clearly demonstrate the reconnaissance and initial access phases of the attack and complement the host-based evidence used to reconstruct the incident timeline.

Together, the network and host artifacts provide a comprehensive view of the simulated compromise and illustrate the value of correlating multiple telemetry sources during incident response.