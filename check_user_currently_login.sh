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

# Check if the user is logged in
is_logged_in=false

for session in $(sudo ls /proc | grep -E "^[0-9]+$"); do
  if sudo grep -q "Uid:.*$(id -u "$username")" "/proc/$session/status" 2>/dev/null; then
    is_logged_in=true
    break
  fi
done

if [ "$is_logged_in" = true ]; then
  echo "User $username is currently logged in."
else
  echo "User $username is not logged in."
fi
