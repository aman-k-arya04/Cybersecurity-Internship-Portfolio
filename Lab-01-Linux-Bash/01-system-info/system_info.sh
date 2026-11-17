#!/bin/bash

# =======================
# PROJECT 01: LINUX SYSTEM INFO TOOL
# =======================

echo "==============================="
echo "     LINUX SYSTEM INFO         "
echo "==============================="

echo ""
echo "[1] OPERATING SYSTEM"
grep PRETTY_NAME /etc/os-release

echo ""
echo "[2] CPU INFO"
lscpu | grep -E '^(Model name|CPU\(s\)):'

echo ""
echo "[3] MEMORY INFO"
free -h

echo ""
echo "[4] DISK USAGE"
df -h /

echo ""
echo "[5] SYSTEM UPTIME"
uptime -p

echo ""
echo "[6] CURRENT USER"
whoami

echo ""
echo "[7] HOSTNAME"
hostname

echo ""
echo "[8] KERNEL VERSION"
uname -r

echo ""
echo "[9] DATE AND TIME"
date

echo "======= INFO COMPLETE ==========="

