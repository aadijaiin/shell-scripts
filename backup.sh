#!/usr/bin/env bash

echo "Automated backup script!"

SOURCE="${1:-$PWD}"

if [ -n "$SOURCE" ] && [ -d "$SOURCE" ] ; then
    echo
else 
    echo "Invalid source!"
    exit 1
fi

BACKUP_ROOT="$HOME/Desktop/backups"
mkdir -p "$BACKUP_ROOT"


BACKUP_DIR="$BACKUP_ROOT/$(basename "$SOURCE")_backups"

mkdir -p "$BACKUP_DIR"

# echo $SOURCE $BACKUP_DIR


tar -czf \
    "$BACKUP_DIR/$(basename "$SOURCE")_$(date +%F_%H-%M-%S).tar.gz" \
    -C "$(dirname "$SOURCE")" \
    "$(basename "$SOURCE")"


if [ $? -eq 0 ]; then
    echo "Backup created successfully."
else 
    echo "There was a problem in generating backup."
    exit 1
fi

RETENTION_DAYS=7
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +$RETENTION_DAYS -delete
