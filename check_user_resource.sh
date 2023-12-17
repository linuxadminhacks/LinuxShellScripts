# This script check User resource when logged in (Home Directory size, number of process and memory usage)

#!/bin/bash

# Take the username as input
# Check if username is empty
read -p "Enter Username: " username

if [ -z "$username" ]; then
   echo "Username is empty."
   exit 1
fi

if [ $username == "root" ]; then
   home="/root"
else
   home="/home/$username"
fi

# Check if the user exists
if id "$username" &>/dev/null; then
    echo "User $username exists."

   # Display the size of the home directory of the specified user
   home_size=$(du -sh $home)
   echo "Home directory size: $home_size"

   # Check how the user is logged in
   if who -u | grep -wq "$username"; then
       echo "User $username logged in."

       # Display the number of processes of the specified user
       proc_count=$(ps -u "$username" | wc -l)
       echo "Number of procress: $proc_count"

       # Display the memory usage of the specified user
       # -U option list processes for a specific user
       # rss shows how much memory is allocated to a process
       mem_usage=$(ps -U "$username" --no-headers -o rss | \
                   awk '{ sum+=$1} END {print int(sum/1024) "MB"}')
       echo "Memory Usage: $mem_usage"
   else
       echo "$username is not logged in"
   fi
else
   echo "User $username does not exist"
fi
