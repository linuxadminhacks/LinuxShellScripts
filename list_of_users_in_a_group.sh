#!/bin/bash

# Read the group name from input
read -p "Enter the group name:" group_name

if [ -z "$group_name" ]; then
 echo "Group name not provided."
 exit 1
fi
 
# Check if the group exists
group_info=$(getent group $group_name)

if [ -z "$group_info" ]; then
 echo "Group does not exist."
else
 # Extract the group name, ID, and members from the group info line
 group_name=$(echo "$group_info" | cut -d: -f1)
 group_id=$(echo "$group_info" | cut -d: -f2)
 members=$(echo "$group_info" | cut -d: -f4)

 # Print the group name, ID, and members
 echo "Group Name: $group_name"
 echo "Group ID: $group_id"

 # Check if the members field is empty
 if [ -z "$members" ]; then
  echo "Members: not member"
 else
  echo "Members: $members"
 fi
fi
