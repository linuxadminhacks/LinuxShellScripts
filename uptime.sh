#!/bin/bash

# Read the /proc/stat file.
# Extract the btime line that shows the boot time in seconds.
# Extract the second column ($2) that shows the numerical value of seconds.
btime_seconds=$(cat /proc/stat | grep "btime" | awk '{print $2}')

# Format seconds to date pattern.
btime_formated=$(date -d @"$btime_seconds" +"%Y-%m-%d %T")

# Convert current date to seconds.
current_date_seconds=$(date +%s)

# Subtract the current date value in seconds from the boot date value in seconds.
# Then we divide the result by 86400, which is the number of seconds of a day.
# The result is the distance between the current day and the system boot time.
diff=$(( (current_date_seconds - btime_seconds ) / 86400 ))

# Print the output
echo "$diff days ago boooted. $btime_formated"
