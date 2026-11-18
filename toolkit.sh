
#!/bin/bash

# Main application

set -uo pipefail


PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

while true; do

    clear

    echo "======================================"
    echo "    LINUX SERVER ADMINISTRATION"
    echo "              TOOLKIT"
    echo "======================================"

    echo ""
    echo "1. Server Health Check"
    echo "2. Disk Monitor"
    echo "3. Service Monitor"
    echo "4. Log Analyzer"
    echo "5. Exit"

    echo ""
    read -rp "Select an option: " OPTION

    case "$OPTION" in

        1)
            bash "$PROJECT_DIR/scripts/server_health_check.sh"
            ;;

        2)
            read -rp "Enter disk threshold (default 80): " THRESHOLD
            THRESHOLD=${THRESHOLD:-80}
            bash "$PROJECT_DIR/scripts/disk_monitor.sh" "$THRESHOLD"
            ;;

        3)
            bash "$PROJECT_DIR/scripts/service_monitor.sh"
            ;;

        4)
            read -rp "Enter log file path: " LOG_FILE
            python3 "$PROJECT_DIR/python/log_analyzer.py" "$LOG_FILE"
            ;;

        5)
            echo "Exiting toolkit. Goodbye!"
            exit 0
            ;;

        *)
            echo "Invalid option. Please try again."
            ;;
    esac

    echo ""
    read -rp "Press Enter to return to the menu..."

done
