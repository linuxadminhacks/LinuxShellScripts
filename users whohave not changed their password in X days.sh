#!/bin/bash

# Read the number of days as input
read -p "Enter the number of days (default is 7): " num_days

# Set the default value if num_days is empty
if [ -z "$num_days" ]; then
  num_days=7
fi

# Print the selected number of days
echo "Checking for users who have not changed their password in $num_days days or more"

# Get the list of all users
all_users=$(grep -vE 'nologin$|false$' /etc/passwd | awk -F':' '$7 ~ "/(bash|sh)$" {print $1}')

# Iterate through the list of users
for user in $all_users
do
  # Get the last password change date for the user
  last_change=$(chage -l $user | grep "Last password change" | cut -d: -f2)

  # Convert the date to seconds since the epoch
  last_change_seconds=$(date -d "$last_change" +%s)

  # Get the current time in seconds since the epoch
  current_seconds=$(date +%s)

  # Calculate the number of days since the last password change
  days_since_change=$(( (current_seconds - last_change_seconds) / 86400 ))

  # Check if the user has not changed their password in the specified number of days
  if [ $days_since_change -gt $num_days ]; then
    echo "User $user has not changed their password in $days_since_change days"
  fi
done
