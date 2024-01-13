#!/bin/bash

# Get all real users with UID >= 1000 or root user ID
# getent passwd return all /etc/passwd lines.

# Please watch the related video.
# Bash Script: How to Find List of All Real Users in Linux
users=$(getent passwd | awk -F: '$3 >= 1000 && $3 < 65534 {print $1}')

# Iterate over each user
for username in $users; do

 # Get the shadow entry for the user
 shadow_entry=$(getent shadow "$username")

 # Extract the password field
 # The -d: option specifies that fields are delimited by colons.
 # The -f2 option specifies that the second field should be extracted.

 password=$(echo "$shadow_entry" | cut -d: -f2)

 case $password in
   '!') echo "$username is a new account with a locked password." ;;
   '!$'*) echo "$username has a expired password." ;;
   '!!') echo "$username has  a locked password." ;;
   '*') echo "$username has a disabled password." ;;
   '') echo "$username has no password." ;;
   *) echo "$username has a normal password status." ;;
 esac
done
