#!/bin/bash

echo "=================================="
echo "       LINUX NETWORK REPORT"
echo "=================================="

# Hostname
echo ""
echo "[1] HOSTNAME"
hostname

# IP Addresses
echo ""
echo "[2] IP ADDRESSES"
ip -brief address

# Network Interfaces
echo ""
echo "[3] NETWORK INTERFACES"
ip link show

# Default Gateway
echo ""
echo "[4] DEFAULT GATEWAY"
ip route | grep default

# Routing Table
echo ""
echo "[5] ROUTING TABLE"
ip route

# DNS Configuration
echo ""
echo "[6] DNS CONFIGURATION"
if [[ -r /etc/resolv.conf ]]; then
    cat /etc/resolv.conf
else
    echo "DNS configuration file not readable."
fi

# MAC Addresses
echo ""
echo "[7] MAC ADDRESSES"
ip -o link show | awk '{print $2, $17}'

# Internet Connectivity
echo ""
echo "[8] INTERNET CONNECTIVITY"

if ping -c 2 -W 3 8.8.8.8 >/dev/null 2>&1; then
    echo "Internet connection is working."
else
    echo "Unable to reach 8.8.8.8."
fi

echo ""
echo "=================================="
echo "       NETWORK REPORT END"
echo "=================================="
