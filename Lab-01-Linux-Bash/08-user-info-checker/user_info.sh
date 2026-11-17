#!/bin/bash

echo "======================================"
echo "       LINUX USER INFORMATION"
echo "======================================"

# Display current user
echo ""
echo "[1] CURRENT USER"

whoami

# Ask for username
echo ""
read -r -p "Enter username to investigate: " USERNAME

# Check whether the user exists
if ! getent passwd "$USERNAME" >/dev/null; then
    echo "Error: User does not exist."
    exit 1
fi

# User ID and group information
echo ""
echo "[2] USER ID AND GROUPS"

id "$USERNAME"

# Group memberships
echo ""
echo "[3] GROUP MEMBERSHIPS"

groups "$USERNAME"

# Home directory
echo ""
echo "[4] HOME DIRECTORY"

HOME_DIR=$(getent passwd "$USERNAME" | cut -d: -f6)

echo "$HOME_DIR"

# Login shell
echo ""
echo "[5] LOGIN SHELL"

LOGIN_SHELL=$(getent passwd "$USERNAME" | cut -d: -f7)

echo "$LOGIN_SHELL"

# Check sudo group membership
echo ""
echo "[6] SUDO PRIVILEGES"

if id -nG "$USERNAME" | grep -qw sudo; then
    echo "User belongs to the sudo group."
else
    echo "User does not belong to the sudo group."
fi

# Logged-in users
echo ""
echo "[7] CURRENTLY LOGGED-IN USERS"

who

echo ""
echo "======================================"
echo "       USER CHECK COMPLETED"
echo "======================================"
