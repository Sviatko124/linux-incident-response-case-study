# Detection Engineering

The rules contained in this directory were developed following the simulated incident.

Rather than investigating the compromise itself, these detections are intended to identify similar attacker behaviour in future incidents.

The repository contains two detection layers:

- Sigma rules (host-based detections)
- Suricata IDS signatures (network-based detections)

Each detection was created directly from attacker activity observed during the incident and mapped to the corresponding MITRE ATT&CK technique where appropriate.

These rules are intended for educational purposes and should be tuned before deployment in a production environment.