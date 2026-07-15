# Recovery

## Objective

The recovery phase verifies that the system can safely return to normal operation after containment and eradication.

---

# System Verification

## Services

Review active services:

```bash
systemctl --type=service --state=running
```

Confirm:

- Required services running
- No unknown services present

---

## Network Verification

Review connections:

```bash
ss -tulpn
```

Confirm:

- No attacker communication
- Expected ports only

---

## Authentication Verification

Review recent logins:

```bash
last
```

Confirm:

- No unauthorized accounts
- No unexpected sessions

---

## Integrity Verification

Compare important files:

```bash
sha256sum /etc/passwd

sha256sum /etc/sudoers
```

Review:

```bash
find / -mtime -1
```

for unexpected modifications.

---

# Recovery Checklist

| Task | Status |
|-|-|
| Malicious processes removed | Complete |
| Persistence removed | Complete |
| Accounts reviewed | Complete |
| Network validated | Complete |
| Services verified | Complete |
| System returned to normal state | Complete |

---

# Final Validation

The system was considered recovered after confirming:

- No active attacker sessions
- No persistence mechanisms
- No suspicious processes
- No unauthorized network communication

Further monitoring would be recommended after restoration.