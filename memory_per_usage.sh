#!/bin/bash

# Define color variables
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get list of users
users=$(who | awk '{print $1}')

# Initialize counter
counter=0

echo "Memory usage per user:"
for user in $users; do
   user_memory=$(ps -u $user -o rss= | awk '{sum+=$1} END {print sum}')
   user_memory=$(echo "scale=2; $user_memory/1024" | bc)
   # Alternate between red and blue
   if ((counter % 2 == 0)); then
       echo -e "${RED}User: $user, Memory Usage: $user_memory MB${NC}"
   else
       echo -e "${BLUE}User: $user, Memory Usage: $user_memory MB${NC}"
   fi

   # Increment counter
   ((counter++))
done
