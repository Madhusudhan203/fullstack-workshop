#!/bin/bash

SOURCE=$1
DEST=$2


if [ ! -d "$SOURCE" ]; then
    echo "Source directory does not exist!"
    exit 1
fi

mkdir -p "$DEST"


TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
FILENAME="backup-$TIMESTAMP.tar.gz"
BACKUP_PATH="$DEST/$FILENAME"


tar -czf "$BACKUP_PATH" -C "$SOURCE" .

SIZE=$(du -h "$BACKUP_PATH" | cut -f1)
echo "Backup created: $FILENAME"
echo "Backup size: $SIZE"


cd "$DEST" || exit
ls -1t backup-*.tar.gz | tail -n +6 | xargs -r rm --

exit 0
