#!/bin/bash

# Method 2 -> # Use the ps command
# to display the start time of the parent process of the current shell.

current_user=$(whoami)

# ps -p $PPID -> selects the processes by PID of the parent process.
# ps -o lstart= -> lstart stands for `start time of the process`

login_time=$(ps -p $PPID -o lstart=)

# Print login time of current user.

echo "Login Time of Current User:"
echo "$current_user     $login_time"
