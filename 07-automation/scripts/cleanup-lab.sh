#!/bin/bash

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
EVIDENCE="$PROJECT_ROOT/evidence"

echo "[*] Stopping tcpdump..."

if [ -f "$EVIDENCE/pcaps/tcpdump.pid" ]
then
    kill "$(cat "$EVIDENCE/pcaps/tcpdump.pid")"
    rm "$EVIDENCE/pcaps/tcpdump.pid"
    echo "[✓] tcpdump stopped."
else
    echo "[!] No PID file found."
fi

logger "=== INCIDENT SIMULATION COMPLETE ==="

date -u > "$EVIDENCE/timeline/end_time_utc.txt"

echo

echo "[*] Creating archive..."

tar -czf evidence_archive.tar.gz "$EVIDENCE"

echo "[✓] Archive created."

echo

echo "Cleanup complete."
