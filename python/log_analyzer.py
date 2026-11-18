
#!/usr/bin/env python3

# Tool: Log Analyzer
# Description: Analyzes log files and detects incidents.

import sys
from collections import Counter

def analyze_logs(file_path):

    # Store detected log levels
    counts = Counter()

    # Read the log file
    try:
        with open(file_path, "r", encoding="utf-8") as file:

            lines = file.readlines()

    except FileNotFoundError:
        print(f"ERROR: File not found: {file_path}")
        return 2

    # Analyze each line
    for line in lines:

        for level in ["INFO", "WARNING", "ERROR", "CRITICAL"]:

            if level in line:
                counts[level] += 1
                break

    # Display report
    print("======================================")
    print("             LOG ANALYZER")
    print("======================================")

    print(f"File analyzed: {file_path}")
    print(f"Total lines: {len(lines)}")

    print("\n[LOG SUMMARY]")

    for level in ["INFO", "WARNING", "ERROR", "CRITICAL"]:
        print(f"{level}: {counts[level]}")

    print("\n[DETECTED INCIDENTS]")

    for line in lines:
        if "ERROR" in line or "CRITICAL" in line:
            print(line.strip())

    print("======================================")

    return 0


if __name__ == "__main__":

    if len(sys.argv) != 2:
        print("Usage: python3 log_analyzer.py <log_file>")
        sys.exit(2)

    sys.exit(analyze_logs(sys.argv[1]))
