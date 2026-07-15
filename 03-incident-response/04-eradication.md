# Eradication

## Objective

The eradication phase removes all remaining attacker artifacts and verifies that the compromised system no longer contains unauthorized access mechanisms.

---

# Remove Unauthorized Access

The compromised account was reviewed.

Commands:

```bash
cat /etc/passwd

last

lastlog
```

The account was removed or secured depending on operational requirements.

---

# Remove Persistence Mechanisms

Cron jobs were reviewed:

```bash
crontab -l

sudo crontab -l
```

Any unauthorized entries were removed.

Verification:

```bash
find /etc/cron* -type f
```

---

# Remove Suspicious Files

Temporary locations were reviewed:

```bash
find /tmp -type f

find /var/tmp -type f
```

Unknown attacker-created files were removed.

---

# Validate System State

Processes:

```bash
ps aux
```

Network:

```bash
ss -tulpn
```

Open files:

```bash
sudo lsof
```

Verification goals:

- No reverse shells
- No unauthorized processes
- No suspicious connections
- No persistence mechanisms

---

# Eradication Summary

The attacker-controlled components were removed and the system was prepared for recovery validation.