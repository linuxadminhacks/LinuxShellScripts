#!/bin/bash

# Function to check if service is running using initd
# $1 is the first argument passed to the function on the lines below.
# The status variable holds the value of the exit code.
# If the service exists, then the service is active
checkInitdStatus() {
    service_name=$1
    status=$(service $service_name status 2>&1)
    
    if [[ $status == *"running"* ]]; then
        echo "Service $service_name is active.”
    else
        echo "Service $service_name is not active or not installed.”
    fi
}


# Function to check if service is running using systemd
# $1 is the first argument passed to the function on the lines below.
# The status variable holds the value of the exit code.
# If the service exists, then the service is active
checkSystemdStatus() {
    service_name=$1
    status=$(systemctl is-active $service_name 2>&1)
    
    if [[ $status == "active" ]]; then
        echo "Service $service_name is active.”
    else
        echo "Service $service_name is not active or not installed."
    fi
}



# Codes that run first
# Get service name from input
read -p "Enter the service name: " service_name

# Check if service is installed
# The service command is for initd
if command -v service >/dev/null 2>&1; then
    # System uses initd
    echo "System uses initd."
    checkInitdStatus $service_name  # Function call, $service_name passed to function

# Check if systemctl is installed
# The systemctl command is for systemdd
elif command -v systemctl >/dev/null 2>&1; then
    # System uses systemd
    echo "System uses systemd."
    checkSystemdStatus $service_name
else
    echo "Service management system not found."
    exit 1
fi
