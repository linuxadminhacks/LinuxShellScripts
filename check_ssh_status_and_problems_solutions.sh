#!/bin/bash

# Read remote_user from user input
read -p "Enter remote user: " remote_user

# Check if remote_user is empty
if [[ -z $remote_user ]]; then
  echo "Error: Remote user cannot be empty"
  exit 1
fi

# Read remote_host from user input
read -p "Enter remote host: " remote_host

# Check if remote_host is empty
if [[ -z $remote_host ]]; then
  echo "Error: Remote host cannot be empty"
  exit 1
fi

# Check if remote_host matches IP pattern
ip_pattern='^([0-9]{1,3}\.){3}[0-9]{1,3}$'
if ! [[ $remote_host =~ $ip_pattern ]]; then
  echo "Error: Remote user is not a valid IP address"
  exit 1
fi

# Read remote_port from user input
read -p "Enter remote port (leave empty for default port 22): " remote_port

# Set default port to 22 if port is empty
if [[ -z $remote_port ]]; then
  remote_port=22
fi

# Check if SSH connection is successful
ssh -q -o ConnectTimeout=5 -p $remote_port $remote_user@$remote_host exit 2>/dev/null

if [[ $? -eq 0 ]]; then
  echo "SSH connection to $remote_host successful"
else
  echo "SSH connection to $remote_host failed"

  # Check for common SSH connection problems and suggest solutions
  if [[ $? -eq 255 ]]; then
    echo "Possible problems and solutions:"
    echo "- The remote host may not be reachable. Check your network connectivity."
    echo "- The SSH service may not be running on the remote host. Start the SSH service on the remote host."
  elif [[ $? -eq 1 ]]; then
    echo "Possible problems and solutions:"
    echo "- The remote user may not exist on the remote host. Make sure the remote user is created on the remote host."
    echo "- The remote user may not have permission to log in via SSH. Grant SSH access to the remote user on the remote host."
    echo "- The remote user's SSH public key may not be added to the authorized_keys file on the remote host. Add the SSH public key to the authorized_keys file."
  fi
fi
