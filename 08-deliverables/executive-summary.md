# Executive Summary

This case study demonstrates the complete lifecycle of a simulated Linux security incident, from initial compromise through incident response and recovery.

The simulated attacker successfully gained access to a Linux host using an SSH password brute-force attack, escalated privileges through a misconfigured `sudo` permission, established persistence, and simulated the exfiltration of sensitive data.

Following the compromise, the incident was investigated using host logs, process information, packet captures, and network analysis. The collected evidence was used to reconstruct the attack timeline, identify indicators of compromise, map activity to the MITRE ATT&CK framework, and develop Sigma and Suricata detections to improve future visibility.

The objective of this project was not simply to demonstrate offensive techniques, but to showcase the complete investigative workflow used during a real incident response engagement.