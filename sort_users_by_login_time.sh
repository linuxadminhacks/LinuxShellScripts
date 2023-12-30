#!/bin/bash

# Function to calculate elapsed time.
# Takes an argument as the user's login time ($1).
# Variable $1 is the first input argument of the function.
calculateElapsedTime(){

  # Get current timestamp
  current_time=$(date +%s)

  # Convert login time to timestamp
  login_time=$(date -d "$1" +%s)

  # Calculate elapsed time in seconds
  elapsed_seconds=$((current_time - login_time))

  # Format elapsed time
  elapsed_time=$(date -u -d @"$elapsed_seconds" +'%H:%M:%S')

  # Returns the value of the $elapsed_time variable.
  echo "$elapsed_time"
} # end of function

# The following codes are executed first and call the above function.

# Print table header
echo "User    @Login    Elpased"
echo "------------------------------"

# Iterate over who output and print values
if [[ "$1" == "-r" ]]; then
   who | awk '{printf "%-8s%s\n", $1, $4}'| sort -k1 -r | 
       while read -r user login_time; do
           elapsed=$(calculateElapsedTime "$login_time") # Function Call
           printf "%-8s%s    %s\n" "$user" "$login_time" "$elapsed"
       done # end of while
else
   who | awk '{printf "%-8s%s\n", $1, $4}' | 
       while read -r user login_time; do
           elapsed=$(calculateElapsedTime "$login_time")
           printf "%-8s%s    %s\n" "$user" "$login_time" "$elapsed"
       done
fi # end of if
