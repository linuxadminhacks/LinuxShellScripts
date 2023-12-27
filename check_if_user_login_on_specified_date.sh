#!/bin/bash

username=$1
target_date=$2

if [[ $# -ne 2 ]]; then
   echo "Username or Date not provided."
   echo "Usage: $0 <username> <date>."
   exit 1
fi

if ! id $username >/dev/null 2>&1; then
   echo "User $username not found."
   exit 1
fi

# Check if the target date is in the correct format
if [[ $target_date =~ ^[0-9]+$ ]]; then
 target_date="$target_date days ago"
 target_date=$(date -I -d "$target_date")
fi

target_date=$(date -I -d "$target_date")

# Set the start and end dates to cover the entire day for the target date
start_date="${target_date}T00:00:00"
end_date="${target_date}T23:59:59"

# Check if the user logged in on the target date
if last --time-format=iso -s $start_date -t $end_date | grep -q  "$username"; then
 echo "User $username logged in on $target_date."
else
 echo "User $username did not log in on $target_date."
fi
