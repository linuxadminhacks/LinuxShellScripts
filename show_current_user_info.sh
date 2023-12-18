#!/bin/bash

# Print the current user
echo "Current user: $(whoami)"

# Print the total size of the home directory
echo "Total size of home directory: $(du -sh $HOME | cut -f1)"

# Print the login time and duration
echo "Logged in since: $(who | grep "$(whoami)" | awk '{print $4}'"
echo "Time remaining: $(uptime | awk '{print $3, $4}')"

# Print the last login time
echo "Last login time: $(lastlog -u $(whoami) | awk '{print $4, $5, $6}')"

# Print the last password change time
echo "Last password change: $(chage -l $(whoami) | grep "Last password change" | awk -F: '{print $2}')"
