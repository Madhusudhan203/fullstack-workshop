#!/bin/bash

THRESHOLD=${1:-90}
ALERT=0

df -P | awk 'NR>1 {print $1, $5}' | while read FS USE; do
    USE_NUM=${USE%\%}

    if [ "$USE_NUM" -ge "$THRESHOLD" ]; then
        echo "WARNING: $FS is at $USE (threshold: $THRESHOLD%)"
        ALERT=1
    else
        echo "OK: $FS is at $USE"
    fi
done

exit $ALERT
