#!/bin/bash

# Ask for username and password
echo "Please enter a username:"
read username

# read -s used to hide sensitive information input
echo "Please enter a password:"
read -s password

# Ask for the quota size in GB
echo "Please enter the quota size in GB:"
read size

# Check if username, password, and size are not empty
if [[ -z "$username" || -z "$password" || -z "$size" ]]; then
 echo "Username, password, or size is empty."
 exit 1
fi

# Create a new user with the given username and password
useradd -m $username
echo "$username:$password" | chpasswd

# Set a quota of the specified size for the user's home directory
echo "$username:$size"G | edquota -f -
