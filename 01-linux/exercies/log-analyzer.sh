#!/bin/bash

logfile=$1
if [ ! -f "$logfile" ]
then
    echo "File not Found"
    exit 1
fi
total_lines=$(wc -l < "$logfile")
info=$(grep -c "INFO" "$logfile")
warning=$(grep -c "WARNING" "$logfile")
error=$(grep -c "ERROR" "$logfile")

IP_LIST=$(grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' "$logfile" | sort | uniq)

echo "========== LOG ANALYSIS REPORT =========="
echo "File: $logfile"
echo "Total Lines: $total_lines"
echo "-----------------------------------------"
echo "INFO:    $info"
echo "WARNING: $warning"
echo "ERROR:   $error"
echo "-----------------------------------------"
echo "Unique IP Addresses Found:"

if [ -z "$IP_LIST" ]
then
    echo "  None"
else
    for ip in $IP_LIST
    do
        echo "  - $ip"
    done
fi
echo "========================================="