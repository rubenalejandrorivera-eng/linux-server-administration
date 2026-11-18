
#!/bin/bash

# Tool: Service Monitor
# Description: Checks the status of Linux services.

set -uo pipefail


SERVICES=("ssh" "cron" "apache2" "docker")

echo "======================================"
echo "          SERVICE MONITOR"
echo "======================================"


ACTIVE=0
INACTIVE=0
NOT_FOUND=0


for SERVICE in "${SERVICES[@]}"; do

    if ! systemctl list-unit-files "${SERVICE}.service" --no-legend 2>/dev/null | grep -q "^${SERVICE}.service"; then
        echo "[NOT FOUND] $SERVICE"
        ((NOT_FOUND+=1))
        continue
    fi

    if systemctl is-active --quiet "$SERVICE"; then
        echo "[ACTIVE]    $SERVICE"
        ((ACTIVE+=1))
    else
        echo "[INACTIVE]  $SERVICE"
        ((INACTIVE+=1))
    fi

done

echo ""
echo "======================================"
echo "             SUMMARY"
echo "======================================"

echo "Active services:   $ACTIVE"
echo "Inactive services: $INACTIVE"
echo "Not found:         $NOT_FOUND"

echo "======================================"
