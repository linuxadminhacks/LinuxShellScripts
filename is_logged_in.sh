#!/bin/bash

# Prompt for the username

read -p "Enter the username: " username

# Check if the username is empty

if [ -z "$username" ]; then
   echo "Username cannot be empty."
   exit 1
fi

# Check if the user exists

if ! id "$username" >/dev/null 2>&1; then
   echo "User $username does not exist."
   exit 1
fi

# Boolean variable with a default value of false.
# To check if the user is logged in or not

is_logged_in=false

# Iterates over the directories in /proc,
# that correspond to running processes.
# grep -E "^[0-9]+$" -> All directories related to process ID are selected.
# one or more digits.
for session in $(ls /proc | grep -E "^[0-9]+$"); do

  # Filters the output of ls /proc to only include,
  # entries that consist of one or more digits.
  if grep -q "Uid:.*$(id -u "$username")" "/proc/$session/status" 2>/dev/null; then
     is_logged_in=true
     break
  fi
done

# Check the value of the is_logged_in variable,
# rints an appropriate message based on whether,
# the user is currently logged in or not.
if [ "$is_logged_in" = true ]; then
   echo "User $username is currently logged in."
else
   echo "User $username is not logged in."
fi
