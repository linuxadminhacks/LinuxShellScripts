#!/bin/bash

# Check for correct number of arguments
# Two arguments is required as username and a existing group name

# $0 is shell script filename
if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <username>"
        exit 1
fi

# $1 refers to the first argument
username=$1

# Define the default_passwd variable
default_password=“P@ssw0rd"

# Check if the username already exists
if id "$username” &>/dev/null; then
        echo "Error: Username already exists"
        exit 1
fi

# Create user with provided username and default password
sudo useradd -m -p $(openssl passwd -1 $default_password) -s /bin/bash $username>

# Set SSH login permission
sudo mkdir /home/$username/.ssh
sudo touch /home/$username/.ssh/authorized_keys
sudo chown -R $username:$username /home/$username/.ssh
sudo chmod 700 /home/$username/.ssh
sudo chmod 600 /home/$username/.ssh/authorized_keys

# Force user to change password at first login

sudo chage -d 0 $username
