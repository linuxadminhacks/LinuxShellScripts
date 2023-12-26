#!/bin/bash

username=$1
target_date=$2

# Check if the target date is in the correct format
if [[ ! $target_date =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]
then
 echo "Invalid date format. Please enter date in the format YYYY-MM-DD."
 exit 1
fi

# Convert the date to the correct format if it is not already
target_date=$(date -I -d "$target_date")

# Set the start and end dates to cover the entire day for the target date
start_date="${target_date}T00:00:00"
end_date="${target_date}T23:59:59"

# Check if the user logged in on the target date
if last --time-format=iso -s $start_date -t $end_date | grep -q "^$username"; then
 echo "User $username logged in on $target_date."
else
 echo "User $username did not log in on $target_date."
fi
