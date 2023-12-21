#!/bin/bash

# Create an array of shell paths
shells=("/bin/bash" "/bin/sh" "/bin/ksh" "/bin/zsh" "/bin/tcsh")

# Loop through each username from the /etc/passwd file
for user in $(cut -d: -f1 /etc/passwd); do
 # Check the shell of the current user using awk
 shell=$(awk -F: -v user="$user" '$1 == user {print $7}' /etc/passwd)

 # Check if the shell is in the array
 for s in "${shells[@]}"; do
  if [[ $s == $shell ]]; then
    # If the shell is in the array, the user has a shell to log in.
    # Check last login information for the current user using lastlog
    if lastlog -u $user | grep -q "Never logged in"; then
      # If "Never logged in" is found, the user has never logged in.
      # Print a message indicating that.
      echo "$user has a shell to log in and has never logged in"
    fi
    break
  fi
 done
done
