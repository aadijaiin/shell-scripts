#!/usr/bin/env bash

echo "Automated backup script!"

SOURCE="$1"

if [ -n "$SOURCE" ] && [ -d "$SOURCE" ] ; then
    MODE="d"
elif [ -n "$SOURCE" ] && [ -f "$SOURCE" ]; then
    MODE="f"
else 
    echo "Invalid source!"
    exit 1
fi

DESTINATION="$2"

if [ -n "$DESTINATION" ] && [ -d "$DESTINATION" ] ; then
    SOURCE_NAME=$(basename "$SOURCE")
    BACKUP_DIR="$DESTINATION/backups_$SOURCE_NAME"
    mkdir -p "$BACKUP_DIR"
else 
    echo "Invalid destination! please enter a valid path to store the backups."
    exit 1
fi

tar -czf \
  "$BACKUP_DIR/${SOURCE_NAME}_$(date +%F_%H-%M-%S).tar.gz" \
  -C "$(dirname "$SOURCE")" \
  "$SOURCE_NAME"

echo "Backup created successfully."

RETENTION_DAYS=7
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +$RETENTION_DAYS -delete
