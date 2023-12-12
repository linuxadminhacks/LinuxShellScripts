#!/bin/bash

# Function to check if a remote server is up or down using nc
# Define local variables for the checkServerStatus function
# ${2:-22}  Use provided port or default to 22
# $1 is the first argument and $2 is the second argument of the function
# timeout Set the timeout value for nc in seconds
check_server_status() {
    local remote_server="$1"
    local port="${2:-22}"
    local timeout=3

    if nc -z -w "$timeout" "$remote_server" "$port" &> /dev/null; then
        echo "The remote server is UP."
    else
        echo "The remote server is DOWN."
    fi
}

# Check if the user provided a server address
# $1: Refers to the first command-line argument
if [ -z "$1" ]; then
    echo "Usage: $0 <remote_server> [port]"
    exit 1
fi

# Run the script with the provided server address and port (or use default)
check_server_status "$1" "$2"   # function call
