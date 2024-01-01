#!/bin/bash

# Get the current memory usage percentage
memory_usage=$(free | awk '/Mem/ {printf("%.2f"), $3/$2 * 100}')

# Define the threshold percentage
threshold=80

# Check if the memory usage exceeds the threshold
if (( $(echo "$memory_usage > $threshold" | bc -l) )); then
    # Get the current date and time
    current_date=$(date +"%Y-%m-%d %T")

    # Write the date and message to a file
    echo "$current_date" >> memory_log.log
    echo "Memory usage exceeded $threshold% threshold!" >> memory_log.txt

    # Print the top 10 processes with the highest memory usage
    echo "Top 10 processes by memory usage:" >> memory_log.log
    ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 11 >> memory_log.log
fi
