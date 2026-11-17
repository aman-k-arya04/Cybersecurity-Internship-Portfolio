#!/bin/bash

# Function to pause the menu
pause_menu() {
    echo ""
    read -r -p "Press Enter to return to the menu..."
}

# Function 1: System Information
system_info() {
    echo ""
    echo "----- SYSTEM INFORMATION -----"
    echo "Hostname: $(hostname)"
    echo "Operating System: $(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2- | tr -d '"')"
    echo "Kernel: $(uname -r)"
    echo "Current User: $(whoami)"
    echo "Date: $(date)"
}

# Function 2: Disk Usage
disk_usage() {
    echo ""
    echo "----- DISK USAGE -----"
    df -h /
}

# Function 3: Memory Usage
memory_usage() {
    echo ""
    echo "----- MEMORY USAGE -----"
    free -h
}

# Function 4: Network Information
network_info() {
    echo ""
    echo "----- NETWORK INFORMATION -----"
    ip -brief address
    echo ""
    echo "Default Gateway:"
    ip route | grep default
}

# Function 5: Running Processes
process_info() {
    echo ""
    echo "----- TOP 5 CPU PROCESSES -----"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}

# Function 6: Logged-in Users
logged_users() {
    echo ""
    echo "----- LOGGED-IN USERS -----"
    who
}

# Function 7: Current Directory
current_directory() {
    echo ""
    echo "----- CURRENT DIRECTORY -----"
    pwd
}

# Function 8: List Files
list_files() {
    echo ""
    echo "----- FILES AND DIRECTORIES -----"
    ls -lah
}

# Function 9: Internet Connectivity
internet_check() {
    echo ""
    echo "----- INTERNET CONNECTIVITY -----"

    if ping -c 2 -W 3 8.8.8.8 >/dev/null 2>&1; then
        echo "Successfully reached 8.8.8.8."
    else
        echo "Unable to reach 8.8.8.8."
    fi
}

# Main menu
while true
do
    echo ""
    echo "========================================"
    echo "       LINUX ADMINISTRATION TOOL"
    echo "========================================"
    echo "1. Display System Information"
    echo "2. Check Disk Usage"
    echo "3. Check Memory Usage"
    echo "4. Display Network Information"
    echo "5. Display Running Processes"
    echo "6. Check Logged-in Users"
    echo "7. Display Current Directory"
    echo "8. List Files"
    echo "9. Check Internet Connectivity"
    echo "10. Exit"
    echo "========================================"

    read -r -p "Enter your choice (1-10): " CHOICE

    case "$CHOICE" in
        1) system_info; pause_menu ;;
        2) disk_usage; pause_menu ;;
        3) memory_usage; pause_menu ;;
        4) network_info; pause_menu ;;
        5) process_info; pause_menu ;;
        6) logged_users; pause_menu ;;
        7) current_directory; pause_menu ;;
        8) list_files; pause_menu ;;
        9) internet_check; pause_menu ;;
        10)
            echo "Exiting Linux Administration Tool."
            break
            ;;
        *)
            echo "Invalid choice. Please select a number from 1 to 10."
            pause_menu
            ;;
    esac
done
