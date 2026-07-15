# Attack Timeline


This timeline documents the chronological progression of the simulated attack against the Linux target host. The timeline was reconstructed using: 
- Network packet captures 
- SSH authentication logs 
- Process information 
- Cron configuration evidence 
- Command execution records 

---

## Incident Window 

**Incident Start:** 
Sun Jul 12 06:22:12 PM UTC 2026 

**Incident End:** 
Sun Jul 12 06:29:49 PM UTC 2026 


---

# Timeline

| **Time** | **Event**                            | **Evidence**                  |
| -------- | ------------------------------------ | ----------------------------- |
| 14:22    | Nmap Reconnaisance                   | nmap_capture.pcapng           |
| 14:23    | SSH Bruteforce                       | ssh_bruteforce_capture.pcapng |
| 14:23    | Valid SSH login achieved             | ssh.log                       |
| 14:25    | Privilege escalation via SUID binary | processes.txt                 |
| 14:28    | Data exfiltration                    | processes.txt                 |
| 14:29    | Persistence created                  | root_cron.txt                 |


---

# Impact

The simulated attacker achieved:

- Unauthorized access to the host
- Privileged root access
- Access to sensitive files
- Ability to transfer data externally
- Ability to maintain persistence

The next phase of this case study analyzes how these actions could have been detected and investigated by a security operations team.