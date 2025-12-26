#!/bin/bash

PROCESS=$1
INTERVAL=$2

if ! tasklist | grep -i "$PROCESS" > /dev/null; then
    echo "Process '$PROCESS' is not running"
    exit 1
fi

echo "Monitoring process '$PROCESS' every $INTERVAL seconds..."

while true; do
    TIME=$(date "+%Y-%m-%d %H:%M:%S")

    if tasklist | grep -i "$PROCESS" > /dev/null; then
        echo "[$TIME] $PROCESS is running"
    else
        echo "[$TIME] ALERT: $PROCESS has stopped!"
        exit 0
    fi

    sleep "$INTERVAL"
done

