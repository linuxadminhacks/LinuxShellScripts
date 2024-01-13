!/bin/bash

# Get a list of all users

# Please watch the related video.
# Bash Script: How to Find List of All Real Users in Linux

users=$(getent passwd | awk -F: '$3 >= 1000 && $3 < 65534 {print $1}')

# Iterate over the list of users
for username in $users; do

 # Get the hashed password for the current user

 # Please watch the related video
 # Bash script: How to check users passwotd status in linux with getent shadow command

 enc_type=$(getent shadow "$username" | cut -d: -f2)

 # Determine the encryption type
 # The ${enc_type:0:3} is used for substring extraction
 # substring starting from index 0 and of length 3 characters

 case "${enc_type:0:3}" in
   '$1$') echo "User $username uses MDF" ;;
   '$2a$') echo "User $username uses BlowFish" ;;
   '$5$') echo "User $username uses SHA-256" ;;
   '$6$') echo "User $username uses SHA-512" ;;
   '$y$') echo "User $username uses yescript" ;;
   *) echo "No password or blocked or expired password found for user $username" ;;
 esac
done
