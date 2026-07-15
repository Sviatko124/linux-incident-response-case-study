# Lab Notes and Architecture Considerations

## Environment Design Decision

To keep the project reproducible with minimal hardware requirements, the entire attack simulation was performed using a single Kali Linux virtual machine.

The VM acted as both:

- The attacker environment
- The compromised victim environment

This design allowed the complete incident lifecycle to be demonstrated while maintaining a lightweight and repeatable laboratory environment.

---

# Network Topology Limitation

Because both attacker and victim activity occurred on the same virtual machine, some network artifacts differ from what would be observed in a production environment.

Examples:

- Network captures may show the same host as both source and destination.
- Attacker and victim processes exist on the same operating system.
- Enterprise segmentation controls are not represented.
- Real-world network boundaries are simplified.

These limitations are documented to maintain transparency and clarify the scope of the simulation.

---

# Applicability to Real SOC Environments

Although the network architecture is simplified, the investigation workflow remains applicable to real security operations.

The same analytical process would be performed in a production environment:

## Network Investigation

Security analysts would still:

- Capture suspicious network activity
- Review connections
- Identify unusual communication patterns
- Investigate possible command-and-control traffic

Tools such as:

- Wireshark
- Zeek
- Suricata

provide the same type of visibility regardless of environment size.

---

## Host Investigation

The investigation methodology remains consistent.

Analysts still review:

- Authentication activity
- Process execution
- Network connections
- Scheduled tasks
- File modifications
- User activity

The core investigation questions remain:

- Who accessed the system?
- How was access obtained?
- What commands were executed?
- Were privileges elevated?
- Was persistence established?
- Was data accessed or transferred?

---

# Collected Telemetry

The following telemetry sources were collected during the exercise:

| Source | Purpose |
|---|---|
| journalctl | System events and SSH authentication records |
| SSH logs | Login attempts and successful authentication |
| tcpdump | Full packet capture |
| Wireshark | Packet analysis |
| Suricata | Network intrusion detection |
| Zeek | Network metadata analysis |
| Process snapshots | Host activity analysis |
| Cron configuration | Persistence investigation |

---

# Project Scope

This project focuses on:

- Attack lifecycle simulation
- Evidence collection
- Incident timeline reconstruction
- Threat detection
- IOC identification
- ATT&CK mapping
- Detection engineering

The objective is not to perfectly reproduce an enterprise network, but to demonstrate the analytical workflow used during a real security incident.

---

# Future Improvements

Potential improvements to increase realism include:

- Separate attacker and victim virtual machines
- Active Directory environment
- Centralized SIEM logging
- Endpoint Detection and Response tooling
- SOAR automation
- Additional operating systems
- Enterprise network segmentation