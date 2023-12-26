#!/bin/bash

# The username is received from the input,
# and saves it in a variable called `username`.
read -p "Enter username: " user

# Checks that variable `username` is not empty.
if [[ -z "$user" ]]; then
   echo "No username provided."
   exit 1
fi

# Checks the user exists.
if ! id "$user"  >/dev/null 2>&1; then
    echo "User $user not found."
    exit 1
fi

# Get the home directory of the user
home_dir=$(getent passwd "$user" | cut -d: -f6)
echo "User home directory: $home_dir"
