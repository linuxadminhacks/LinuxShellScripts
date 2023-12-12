#!/bin/bash

# Function to validate IP address format using regex
validateIP() {
    local ip=$1
    local regex="^([0-9]{1,3}\.){3}[0-9]{1,3}$"

    if [[ ! $ip =~ $regex ]]; then
        echo "Invalid IP address format. Please enter a valid IP."
        read -p "Enter IP address (or 'q' to exit): " ip
        if [ "$ip" == "q" ] || [ "$ip" == "Q" ]; then
            echo "Exiting the program."
            exit 1
        fi
        validateIP "$ip"
    fi
}

# Check if 'curl' and 'jq' commands exist
if ! command -v curl &> /dev/null || ! command -v jq &> /dev/null; then
    echo "Error: curl and jq commands are required but not found. Please install them."
    exit 1
fi

# Read IP address from user input
read -p "Enter IP address (or 'q' to exit): " user_input

# Exit program if 'q' or 'Q' is given
if [ "$user_input" == "q" ] || [ "$user_input" == "Q" ]; then
    echo "Exiting the program."
    exit 0
fi

# Validate IP address format
validateIP "$user_input"

# Get GeoIP information using a web service
geoip_info=$(curl -s "https://ipinfo.io/$user_input/json")

# Parse JSON response to extract relevant details
ip=$(echo $geoip_info | jq -r '.ip')
city=$(echo $geoip_info | jq -r '.city')
region=$(echo $geoip_info | jq -r '.region')
country=$(echo $geoip_info | jq -r '.country')
location=$(echo $geoip_info | jq -r '.loc')

# Display the GeoIP information
echo "IP Address: $ip"
echo "City: $city"
echo "Region: $region"
echo "Country: $country"
echo "Location: $location"
