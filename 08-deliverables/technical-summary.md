# Technical Summary

The simulated attack consisted of the following stages:

1. Network reconnaissance using Nmap.
2. SSH password brute-force attack using Hydra.
3. Successful authentication as the `auditor` user.
4. Privilege escalation through GTFOBins abuse of `ssh-agent`.
5. Access to a sensitive archive.
6. Simulated data exfiltration using Netcat.
7. Cron-based persistence.

Following the attack, the host was investigated using `journalctl`, process listings, network connections, packet captures, and scheduled task analysis.

The incident response process included detection, triage, containment, eradication, recovery, threat hunting, IOC collection, ATT&CK mapping, network analysis, and the creation of Sigma and Suricata detection content.

The project demonstrates the complete incident lifecycle while emphasizing evidence collection, documentation, and defensive analysis.