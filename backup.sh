#!/usr/bin/env bash

echo "Automated backup script!"
TARGETS="$HOME/Desktop/backup_targets"
BACKUP_ROOT="$HOME/Desktop/backups"
mkdir -p "$BACKUP_ROOT"
touch "$TARGETS"

verify_source() {
    local SOURCE=$1
    if [ -d "$SOURCE" ] ; then
        return 0
    else 
        return 1
    fi
}

backup() {

    SOURCE="$(realpath "${1:-$PWD}")" || { echo "invalid path"; return 1; }

    if ! verify_source "$SOURCE"; then 
        echo "invalid source"
        return 1
    fi

    BACKUP_DIR="$BACKUP_ROOT/$(basename "$SOURCE")_backups"
    mkdir -p "$BACKUP_DIR"

    tar -czf \
        "$BACKUP_DIR/$(basename "$SOURCE")_$(date +%F_%H-%M-%S).tar.gz" \
        -C "$(dirname "$SOURCE")" \
        "$(basename "$SOURCE")"


    if [ $? -eq 0 ]; then
        echo "Backup created successfully."
    else 
        echo "There was a problem in generating the backup."
        exit 1
    fi
}

backup_all() {
    while IFS= read -r i; do
        [ -z "$i" ] && continue
        echo "backing up -> $i"
        backup "$i"
    done < "$TARGETS"
}


add_target() {
    TARGET="$(realpath "$1")" || { echo "invalid path"; exit 1; }

    if grep -Fxq -- "$TARGET" "$TARGETS"; then
        echo "Target already exists!"
    else
        if verify_source "$TARGET"; then
            echo "adding target"
            echo "$TARGET" >> "$TARGETS"
            backup "$TARGET"
        else
            echo "invalid source"
        fi
    fi
}


remove_target() {
    echo "removing target"
    if grep -Fxq -- "$1" "$TARGETS"; then
        sed -i "\|^$1$|d" "$TARGETS"
    else
        echo "target not found"
    fi
}

list_targets() {
    echo "listing targets"
    cat "$TARGETS"
}

case "$1" in
    add) 
        add_target "$2"
        ;;
    remove)
        remove_target "$2"
        ;;
    list)
        list_targets
        ;;
    all)
        backup_all
        ;;
    *)
        backup "$1"
        ;;
esac