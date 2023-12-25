#!/bin/bash

# Read length of string from input.
read -p "Enter the length of the random string: " length

string=()

for i in {a..z} {A..Z} {0..9};
do
    string[$RANDOM]=$i
done

# Print a substring of the array.
# :0:$len selects elements starting from index 0 up to $len.


printf %s ${string[@]:0:$length} $'\n'
