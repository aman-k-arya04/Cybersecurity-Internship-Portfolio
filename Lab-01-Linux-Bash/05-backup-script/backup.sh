#!/bin/bash

# Ask the user for the source folder
read -r -p "Enter the folder path to back up: " SOURCE

# Set the backup destination
BACKUP_DIR="$HOME/backups"

# Check whether the source folder exists
if [[ ! -d "$SOURCE" ]]; then
    echo "Error: Source folder does not exist."
    exit 1
fi

# Create the backup directory
mkdir -p "$BACKUP_DIR"

# Generate a timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Extract the folder name
FOLDER_NAME=$(basename "$SOURCE")

# Generate the backup folder name
BACKUP_NAME="${FOLDER_NAME}_backup_${TIMESTAMP}"

# Copy the source folder
cp -a "$SOURCE" "$BACKUP_DIR/$BACKUP_NAME"

# Check whether the backup succeeded
if [[ $? -eq 0 ]]; then
    echo "Backup completed successfully!"
    echo "Backup saved at: $BACKUP_DIR/$BACKUP_NAME"
else
    echo "Backup failed."
    exit 1
fi
