#!/bin/bash

# Check if SSH_CONNECTION is set
if [ -z "$SSH_CONNECTION" ]; then
 echo "You are logged locally not from SSH"
 exit 1
fi

# Split SSH_CLIENT into an array
ssh_info=($SSH_CONNECTION)

# Extract source IP address, source port number, and destination SSH port
source_ip="${ssh_info[0]}"
source_port="${ssh_info[1]}"
destination_ip="${ssh_info[2]}"
destination_port="${ssh_info[3]}"

# Print the extracted information
echo "Source IP: $source_ip"
echo "Source Port: $source_port"
echo "Destination SSH IP: (Server IP): $destination_ip"
echo "Destination SSH Port: $destination_port"
