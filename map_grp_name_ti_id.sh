#!/bin/bash

# Read the group name or group ID from input
read -p "Enter the group name or group ID: " input

# Check if the input is a group name or group ID
# The $input =~ ^[0-9]+$ is a regular expression,
# used in Bash to check if a string contains only digits.
if [[ $input =~ ^[0-9]+$ ]]; then

 # Input is a group ID, convert it to a group name
 # the -z operator is checking if the group_info variable is empty.
 # If the getent command doesn't find a group with the given name or ID,
 # so group_info will be an empty string.
 group_info=$(getent group $input)
 if [ -z "$group_info" ]; then
    echo "Group ID does not exist."
 else
    echo "Group Name: $(echo $group_info | awk -F: '{print $1}')"
 fi
else
 # Input is a group name, convert it to a group ID
 group_info=$(getent group $input)
 if [ -z "$group_info" ]; then
    echo "Group does not exist."
 else
    echo "Group ID: $(echo $group_info | awk -F: '{print $3}')"
 fi
fi
