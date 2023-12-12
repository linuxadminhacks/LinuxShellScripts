#!/bin/bash

# Set the remote hostname and username
remote_host="45.145.6.52"
remote_user="root"

# Check if SSH connection is successful
ssh -q -o ConnectTimeout=5 $remote_user@$remote_host exit 2>/dev/null

if [[ $? -eq 0 ]]; then
  echo "SSH connection to $remote_host successful"
else
  echo "SSH connection to $remote_host failed"
fi
