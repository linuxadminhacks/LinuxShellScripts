#!/bin/bash

# Print the current user
echo "Current user: $(whoami)"

# Print the total size of the home directory
echo "Total size of home directory: $(du -sh $HOME | cut -f1)"

# Print the login time and duration
current_time=$(date +'%H:%M')
logged_at=$(who | grep "$(whoami)" | awk '{print $4}')
current_timestanp=$(date -d "$current_time" +%s)
logged_timestamp=$(date -d "$logged_at" +%s)

difference=$((current_timestamp - logged_timestamp))

logged_time=$(date -u -d @$difference +"%H:%M:%S")

echo "Logged in at: $logged_at"
echo "Total login time: $logged_time"

# Print the last login time
echo "Last login time: $(lastlog -u $(whoami) | awk '{print $4, $5, $6}' | grep -v "Latest")"

# Print the last password change time
echo "Last password change: $(chage -l $(whoami) | grep "Last password change" | awk -F: '{print $2}')"
