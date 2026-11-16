#!/bin/bash

set -euo pipefail

# Get limits from environment variables or use defaults
disk_limit="${DISK_LIMIT:-85}"
mem_limit="${MEM_LIMIT:-80}"

# Set the log file location
log_dir="$HOME/logs"
log_file="$log_dir/health.log"

# Create the log directory if it does not exist
mkdir -p "$log_dir"

# Keep track of whether there is a warning
has_warning=0

# Check if quiet mode is enabled
quiet=0

if [ "${1:-}" = "--quiet" ]; then
    quiet=1
fi

# Write a message to the log file
log_message() {
    local level="$1"
    local message="$2"

    printf '%s [%s] %s\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" \
        "$level" \
        "$message" >> "$log_file"
}

# Print a message unless quiet mode is enabled
print_message() {
    if [ "$quiet" -eq 0 ]; then
        echo "$1"
    fi
}

# Get disk usage percentage
disk_usage=$(df -P / | awk 'NR==2 {gsub("%", "", $5); print $5}')

# Get memory usage percentage
memory_usage=$(free | awk '/Mem:/ {printf "%.0f", $3 / $2 * 100}')

# Get load average and CPU cores
load_average=$(awk '{print $1}' /proc/loadavg)
cores=$(nproc)

# Check disk usage
if [ "$disk_usage" -gt "$disk_limit" ]; then
    disk_level="WARN"
    has_warning=1
    disk_message="Disk ${disk_usage}% WARN (limit ${disk_limit}%)"
else
    disk_level="OK"
    disk_message="Disk ${disk_usage}% OK"
fi

print_message "$disk_message"
log_message "$disk_level" "$disk_message"

# Check memory usage
if [ "$memory_usage" -gt "$mem_limit" ]; then
    memory_level="WARN"
    has_warning=1
    memory_message="Memory ${memory_usage}% WARN (limit ${mem_limit}%)"
else
    memory_level="OK"
    memory_message="Memory ${memory_usage}% OK"
fi

print_message "$memory_message"
log_message "$memory_level" "$memory_message"

# Check load usage per CPU core
if awk -v l="$load_average" -v n="$cores" 'BEGIN { exit !(l / n > 1.0) }'; then
    load_level="WARN"
    has_warning=1
    load_message="Load ${load_average} on ${cores} cores WARN"
else
    load_level="OK"
    load_message="Load ${load_average} on ${cores} cores OK"
fi

print_message "$load_message"
log_message "$load_level" "$load_message"

# Exit with 0 when everything is OK and 1 when there is a warning
exit "$has_warning"