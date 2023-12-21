#!/bin/bash

# Prompt for the username
read -p "Enter username: " username

# Prompt for the password
echo -n "Enter password: "
read -s password
echo

# Prompt for the size in GB
read -p "Enter maximum home directory size in GB: " size_gb

# Create the user
useradd -m $username

# Set the password for the user
echo "$username:$password" | chpasswd

# Convert size to bytes
size_bytes=$((size_gb * 1024 * 1024 * 1024))

# Set the maximum size for the user's home directory
setquota -u $username $size_bytes $size_bytes 0 0 /home

echo "User $username created with a maximum home directory size of $size_gb GB."
