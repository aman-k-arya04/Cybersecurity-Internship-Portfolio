#!/bin/bash

# Disk usage warning threshold
threshold=80

echo "======================================"
echo "        LINUX DISK USAGE MONITOR"
echo "======================================"

# Display disk usage information
echo ""
echo "[1] CURRENT DISK USAGE"

df -h -x tmpfs -x devtmpfs

# Check disk usage percentage
echo ""
echo "[2] DISK USAGE ALERTS"

df -P -x tmpfs -x devtmpfs | awk 'NR>1 {
    usage=$5
    gsub("%", "", usage)

    if (usage >= threshold) {
        print "WARNING: " $6 " is using " usage "% disk space."
    }
}'

echo ""
echo "[3] STORAGE STATUS"

df -P -x tmpfs -x devtmpfs | awk 'NR>1 {
    usage=$5
    gsub("%", "", usage)

    if (usage >= threshold) {
        print $6 ": HIGH DISK USAGE"
    }
    else {
        print $6 ": NORMAL"
    }
}'

echo ""
echo "======================================"
echo "       DISK MONITOR COMPLETED"
echo "======================================"
