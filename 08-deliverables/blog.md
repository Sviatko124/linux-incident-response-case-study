# Simulating the Full Lifecycle of a Linux Security Incident

## Introduction

One thing I noticed while learning cybersecurity is that most home lab projects focus on only one side of security. You either see penetration testing write-ups that end once root access is obtained, or defensive projects that analyze logs without showing how the attack actually happened.

I wanted to build something that connected both perspectives.

This case study follows a complete Linux compromise from beginning to end: starting with reconnaissance and initial access, progressing through privilege escalation and persistence, and finishing with incident response, threat hunting, network analysis, and detection engineering. Every stage is documented with the evidence collected during the investigation, allowing the entire incident to be reconstructed as if it were a real security event. By practicing every stage, I learned a broad range of knowledge, and has helped me identify what I was truly passionate about, which is red teaming and incident response.

The project was intentionally designed to be reproducible using a single virtual machine so that anyone can recreate the environment without requiring enterprise hardware or multiple systems.

---

## Project Overview

The simulated attack follows a realistic intrusion path:

- Network reconnaissance using Nmap
- SSH password brute-force attack
- Initial access through valid credentials
- Privilege escalation via a GTFOBins technique
- Cron-based persistence
- Simulated data exfiltration

After the compromise, the perspective shifts from attacker to defender. The remainder of the project focuses on:

- Incident detection
- Evidence collection
- Timeline reconstruction
- Incident triage
- Containment
- Eradication
- Recovery
- Threat hunting
- IOC collection
- MITRE ATT&CK mapping
- Network traffic analysis
- Detection engineering using Sigma and Suricata

Each phase includes the commands executed, supporting evidence, screenshots, and written documentation explaining both the technical process and the reasoning behind each decision.

---

## What You'll Learn

This project demonstrates how offensive and defensive security fit together during an incident.

By following the case study, you'll see how to:

- Document an attack from start to finish.
- Correlate host logs with network traffic.
- Build an incident timeline from collected evidence.
- Identify indicators of compromise (IOCs).
- Map attacker activity to the MITRE ATT&CK framework.
- Perform basic incident response on a compromised Linux host.
- Write Sigma and Suricata detections based on observed attacker behavior.

The objective isn't simply to "hack a machine," but to understand how defenders investigate, contain, and learn from security incidents.

---

## Architecture

The environment consists of a single Kali Linux virtual machine that simulates both the attacker and the victim. While this differs from a production network, the investigative workflow remains the same, allowing host logs, packet captures, and detection logic to be correlated throughout the incident.

---

## Future Improvements

This project intentionally focuses on a lightweight Linux environment, but there are many ways it could be expanded in the future.

Possible improvements include:

- Deploying Wazuh for centralized endpoint monitoring.
- Integrating Elastic Stack or Splunk for log aggregation and SIEM capabilities.
- Adding Sysmon for Linux to improve host telemetry.
- Creating YARA rules to detect malicious files or tooling.
- Introducing SOAR playbooks to automate portions of the incident response process.
- Expanding the environment to include multiple hosts and lateral movement scenarios.
- Simulating Windows endpoints and Active Directory environments.
- Developing additional Sigma and Suricata detections based on more advanced attack techniques.

Although this project was completed in a home lab, the investigative methodology mirrors the workflow used during real incident response engagements and provides a strong foundation for building more complex security environments in the future.