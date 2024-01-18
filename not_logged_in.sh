#!/bin/bash

# The grep command is used to compare two lists.
# The <() syntax is known as process substitution in Bash.
# Each < () refers to a temporary file.

# getent passwd returns the lines of the /etc/passwd file.
# Watch the video below:
# Bash Script: How to Find List of All Real Users in Linux.

# The grep command compares the output of commands inside two <().

users=$(grep -Fxvf <(who | awk '{print $1}' | sort -u) \
   <(getent passwd | awk -F: '$3 >= 1000 && $3 < 65534 || $3 == 0 {print $1}'))

echo "List of users who are not currently logged in:"
echo "$users"
