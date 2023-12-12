#!/bin/bash

# Function to check if a string is a valid home directory pattern
check_home_directory() {
    # Define the regular expression pattern
    pattern=“^/home/[a-zA-Z][a-zA-Z0-9_]*$"

    # Check if the input string matches the pattern
    if [[ $1 =~ $pattern ]]; then
        echo "Valid home directory pattern."
    else
        echo "Invalid home directory pattern."
    fi
}

# Example usage
input_string="/home/user123"
check_home_directory "$input_string"
