#!/bin/bash

set -euo pipefail

# Get disk usage percentage
disk_usage=$(df -P / | awk 'NR==2 {gsub("%", "", $5); print $5}')

# Get memory usage percentage
memory_usage=$(free | awk '/Mem:/ {printf "%.0f", $3 / $2 * 100}')

# Get load average and CPU cores
load_average=$(awk '{print $1}' /proc/loadavg)
cores=$(nproc)

echo "Disk: ${disk_usage}%"
echo "Memory: ${memory_usage}%"
echo "Load: ${load_average} on ${cores} cores"