#!/bin/bash

echo "======================================"
echo "         LINUX PROCESS MONITOR"
echo "======================================"

# Total running processes
echo ""
echo "[1] TOTAL RUNNING PROCESSES"

PROCESS_COUNT=$(ps -e --no-headers | wc -l)

echo "Total processes: $PROCESS_COUNT"

# Top 5 CPU-consuming processes
echo ""
echo "[2] TOP 5 CPU-CONSUMING PROCESSES"

ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 memory-consuming processes
echo ""
echo "[3] TOP 5 MEMORY-CONSUMING PROCESSES"

ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# Memory information
echo ""
echo "[4] SYSTEM MEMORY"

free -h

# Live process monitoring information
echo ""
echo "[5] SYSTEM LOAD"

uptime

# Search for a specific process
echo ""
echo "[6] SEARCH FOR A PROCESS"

read -r -p "Enter process name to search: " PROCESS_NAME

if pgrep -x "$PROCESS_NAME" >/dev/null; then
    echo "Process found:"
    ps -C "$PROCESS_NAME" -o pid,comm,%cpu,%mem
else
    echo "Process not found."
fi

echo ""
echo "======================================"
echo "       PROCESS MONITOR END"
echo "======================================"
