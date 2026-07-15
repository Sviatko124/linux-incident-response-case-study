#!/bin/bash

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
EVIDENCE="$PROJECT_ROOT/evidence/post_attack"

mkdir -p "$EVIDENCE"

echo "[*] Collecting investigation evidence..."

journalctl > "$EVIDENCE/journalctl.txt"

sudo cp /var/log/auth.log "$EVIDENCE/" 2>/dev/null || true

sudo ausearch -ts today > "$EVIDENCE/auditd.txt" 2>/dev/null || true

ps aux > "$EVIDENCE/processes.txt"

ss -tulpn > "$EVIDENCE/network_connections.txt"

sudo lsof > "$EVIDENCE/lsof.txt"

last > "$EVIDENCE/last.txt"

crontab -l > "$EVIDENCE/user_cron.txt" 2>/dev/null || true

sudo crontab -l > "$EVIDENCE/root_cron.txt" 2>/dev/null || true

systemctl list-units --type=service \
> "$EVIDENCE/services.txt"

find /tmp -type f \
> "$EVIDENCE/tmp_files.txt"

find /var/tmp -type f \
> "$EVIDENCE/var_tmp_files.txt"

echo "[✓] Evidence collection complete."
