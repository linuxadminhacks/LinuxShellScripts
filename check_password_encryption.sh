#!/bin/bash

# Get a list of all users
usernames=$(getent passwd | \
 awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' | \
 cut -d: -f1)

# Iterate over the list of users
for username in $usernames; do
 # Get the hashed password for the current user
 enc_type=$(getent shadow "$username" | cut -d: -f2)

 # Determine the encryption type
 case "${enc_type:0:3}" in
 \$1\$) echo "User $username uses MD5" ;;
 \$2a\$) echo "User $username uses Blowfish" ;;
 \$5\$) echo "User $username uses SHA-256" ;;
 \$6\$) echo "User $username uses SHA-512" ;;
 \$y\$) echo "User $username uses yescrypt" ;;
 *) echo "No password or blocked or expired password found for user $username" ;;
 esac
done

