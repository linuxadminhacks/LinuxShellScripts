#!/bin/bash

# Create an arary to hold a random string.
string=()

# Iterates over a set of characters using `for` loop.
# {a..z} represents all lowercase letters from `a` to `z`.
# {A..Z} represents all lowercase letters from `A` to `Z`.
# {0..9} represents all digits from `0` to `9`.
for i in {a..z} {A..Z} {0..9};
do

    # set the element of the array at index $RANDOM to the value of $i".
    string[$RANDOM]=$i
done

# Print a substring of the array.
# ${array[@]::8} selects the first 8 elements of the array,
# and $'\n', start a new line.
printf %s ${string[@]::8} $'\n'
