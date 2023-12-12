#!/bin/bash

# Function to check if a string is a valid home directory pattern
# The function does not check if the directory actually exists
# It only tests the correctness of the pattern.
checkHomeDirectory(){

    # Define the regular expression pattern
    # Check if the input string matches the pattern
    # $1 is the first argument of the function
    pattern="^(/home/[a-zA-Z][a-zA-Z0-9_]*)|(~/[a-zA-Z][a-zA-Z0-9_]*)$"
    if [[ $1 =~ $pattern ]]; then
       echo "Valid home directory pattern."
    else
       echo "Invalid home directory pattern."
    fi # End of if
} # end of function

# Example Usage
# Functon Call
# Passing the variable $input to the first argument of the function $1
input="/home/user01"
checkHomeDirectory "$input"

input="~/user01"
checkHomeDirectory "$input"
# Invalid because the username starts with a number.
input="/home/0user01"
checkHomeDirectory "$input"
