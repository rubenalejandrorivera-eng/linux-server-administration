
#!/bin/bash

# Tool: Disk Monitor
# Description: Monitors disk usage and generates alerts.

set -euo pipefail

# Configuration
THRESHOLD=${1:-80}
FILESYSTEM="/"

echo "======================================"
echo "           DISK MONITOR"
echo "======================================"


if ! [[ "$THRESHOLD" =~ ^[0-9]+$ ]] || (( THRESHOLD < 1 || THRESHOLD > 100 )); then
    echo "ERROR: Threshold must be between 1 and 100."
    exit 2
fi


DISK_USAGE=$(df -P "$FILESYSTEM" | awk 'NR==2 {gsub("%","",$5); print $5}')

echo "Filesystem: $FILESYSTEM"
echo "Disk usage: ${DISK_USAGE}%"
echo "Alert threshold: ${THRESHOLD}%"


if (( DISK_USAGE >= THRESHOLD )); then
    if (( DISK_USAGE >= 95 )); then
        echo "CRITICAL: Disk usage is critically high!"
        exit 2
    else
        echo "WARNING: Disk usage exceeds the threshold!"
        exit 1
    fi
else
    echo "OK: Disk usage is within normal limits."
    exit 0
fi
