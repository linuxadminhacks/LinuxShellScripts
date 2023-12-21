#!/bin/bash

# Ask for username and password
echo "Please enter a username:"
read username
echo "Please enter a password:"
read password

# Check if username and password are not empty
if [[ -z "$username" || -z "$password" ]]; then
 echo "Username or password is empty."
 exit 1
fi

# Create a new user with the given username and password
useradd -m $username
echo "$username:$password" | chpasswd

# Set a quota of 20G for the user's home directory
echo "$username:20G" | edquota -f -
