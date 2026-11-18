
#!/bin/bash

# Linux Server Administration Toolkit
# Tool: Server Health Check
# Description: Displays basic server health information.

set -euo pipefail

echo "======================================"
echo "       LINUX SERVER HEALTH CHECK"
echo "======================================"


echo ""
echo "[SERVER INFORMATION]"
echo "Hostname: $(hostname)"
echo "Date: $(date)"
echo "Uptime: $(uptime -p)"
echo "CPU Cores: $(nproc)"


echo ""
echo "[MEMORY USAGE]"
free -h


echo ""
echo "[DISK USAGE]"
df -h /


echo ""
echo "[SYSTEM LOAD]"
uptime


echo ""
echo "[TOP 5 PROCESSES BY CPU]"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

echo ""
echo "======================================"
echo "       HEALTH CHECK COMPLETED"
echo "======================================"
