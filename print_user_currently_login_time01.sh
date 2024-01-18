#!/bin/bash

# Method 1 -> # Use the ls command to find the directory creation date.

# Get the username of the current user.

current_user=$(whoami)

# ls -l -> long format.
# ls -rt -> sorted by modification time in reverse order.
# ls -h -> human-readable.
# ls --time-style -> for a custom time format.

# grep $PPID to select the directory with the same name as the shell's PID.

# print $6, $7 to select date and time columns.

login_time=$(ls -lrth --time-style="+%Y-%m-%d %H:%M:%S" /proc | \
             grep "$PPID" | \
             awk '{print $6, $7}')

# Print login time
echo "User login time:"
echo "$current_user     $login_time."
