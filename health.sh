#!/bin/bash

set -euo pipefail

# Get limits from environment variables or use defaults
disk_limit="${DISK_LIMIT:-85}"
mem_limit="${MEM_LIMIT:-80}"

# Get disk usage percentage
disk_usage=$(df -P / | awk 'NR==2 {gsub("%", "", $5); print $5}')

# Get memory usage percentage
memory_usage=$(free | awk '/Mem:/ {printf "%.0f", $3 / $2 * 100}')

# Get load average and CPU cores
load_average=$(awk '{print $1}' /proc/loadavg)
cores=$(nproc)

# Check disk usage
if [ "$disk_usage" -gt "$disk_limit" ]; then
    echo "Disk     ${disk_usage}%   WARN (limit ${disk_limit}%)"
else
    echo "Disk     ${disk_usage}%   OK"
fi

# Check memory usage
if [ "$memory_usage" -gt "$mem_limit" ]; then
    echo "Memory   ${memory_usage}%   WARN (limit ${mem_limit}%)"
else
    echo "Memory   ${memory_usage}%   OK"
fi

# Check load per CPU core
if awk -v l="$load_average" -v n="$cores" 'BEGIN { exit !(l / n > 1.0) }'; then
    echo "Load     ${load_average} on ${cores} cores   WARN"
else
    echo "Load     ${load_average} on ${cores} cores   OK"
fi