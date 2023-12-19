#!/bin/bash

# Print the current user
echo "Current user: $(whoami)"

# Print the total size of the home directory
echo "Total size of home directory: $(du -sh $HOME | cut -f1)"

# Print the login time and duration
current_time=$(date +"%H:%M" )
login_time=$(w | grep $(whoami) | awk '{print $4}')
current_timestamp=$(date -d "$current_time" +%s)
login_timestamp=$(date -d "$login_time" +%s)
difference=$(($current_timestamp - $login_timestamp))
elapsed_time=$(date -u -d @$difference +"%H:%M")


echo "Logged in at: $login_time"
echo "Elapsed time: $elapsed_time"

# Print the last login time
last_login=$(lastlog -u $(whoami) | awk '{print $4, $5, $6}' | grep -v 'Latest')
echo "Last login time: $last_login"

# Print the last password change time
last_chgpass=$(chage -l $(whoami) | grep "Last password change" | awk -F: '{print $2}')
echo "Last password change: $last_chgpass"
