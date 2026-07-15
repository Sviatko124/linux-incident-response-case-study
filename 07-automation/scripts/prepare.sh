#!/bin/bash

# ==========================================================
# Lab Preparation Script
# ==========================================================

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
EVIDENCE="$PROJECT_ROOT/evidence"

echo "====================================="
echo " Preparing Lab Environment"
echo "====================================="

echo "[*] Creating evidence directories..."

mkdir -p \
    "$EVIDENCE/baseline" \
    "$EVIDENCE/logs" \
    "$EVIDENCE/pcaps" \
    "$EVIDENCE/screenshots" \
    "$EVIDENCE/timeline" \
    "$EVIDENCE/reports"

echo "[✓] Directories created."

echo

echo "[*] Recording start time..."

date -u > "$EVIDENCE/timeline/start_time_utc.txt"

echo "[✓] Timestamp saved."

echo

echo "[*] Collecting baseline..."

hostnamectl > "$EVIDENCE/baseline/hostname.txt"

ip addr > "$EVIDENCE/baseline/ip_addr.txt"

ip route > "$EVIDENCE/baseline/routes.txt"

whoami > "$EVIDENCE/baseline/current_user.txt"

who > "$EVIDENCE/baseline/logged_in_users.txt"

last > "$EVIDENCE/baseline/login_history.txt"

ps aux > "$EVIDENCE/baseline/processes.txt"

ss -tulpn > "$EVIDENCE/baseline/network_connections.txt"

systemctl list-units --type=service --state=running \
> "$EVIDENCE/baseline/running_services.txt"

df -h > "$EVIDENCE/baseline/disk_usage.txt"

mount > "$EVIDENCE/baseline/mounts.txt"

echo "[✓] Baseline collected."

echo

echo "[*] Checking services..."

SERVICES=("auditd" "suricata" "zeek")

for SERVICE in "${SERVICES[@]}"
do
    if systemctl is-active --quiet "$SERVICE"
    then
        echo "[✓] $SERVICE is running."
    else
        echo "[!] $SERVICE is NOT running."
    fi
done

echo

echo "[*] Available interfaces:"
ip -brief link

echo
read -p "Capture interface: " IFACE

echo "[*] Starting tcpdump..."

sudo tcpdump -i "$IFACE" \
-w "$EVIDENCE/pcaps/attack_capture.pcap" \
>/dev/null 2>&1 &

echo $! > "$EVIDENCE/pcaps/tcpdump.pid"

echo "[✓] tcpdump started."

echo

logger "=== BEGIN INCIDENT SIMULATION ==="

echo "[✓] Incident marker written."

