#!/bin/bash

if [[ "$#" -ne 1 ]]; then
   echo "Error: Username not provided."
   echo "Usage: $0 <username>"
   exit 1
fi

username=$1

if ! id "$username" >/dev/null 2>&1; then
    echo "User $username does not exist."
    exit 1
fi

lastlog -u "$username" | grep "Never logged in" >/dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "User $username has never logged in."
    exit 1
fi

current=$(last "$username" | grep "still")
if [[ -z $current ]]; then
    echo "User $username is not currently logged in."
    previous=$(last -R  "$username"  | awk 'NR==1 {print $3, $4, $5, $6}')
    echo "Previous login date of user $username: $previous"
else
    previous=$(last -R  "$username"  | awk 'NR==2 {print $3, $4, $5, $6}')
    echo "User $username is currently logged in."
    echo "Previous login date of user $username: $previous"
fi
