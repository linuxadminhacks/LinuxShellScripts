#!/bin/bash

declare -A tcp_services
declare -A udp_services

udp_services=( ["dns"]="53" ["dhcp"]="67" )

tcp_services=( ["ssh"]="22"
               ["http"]="80"
               ["dns"]="53"
               ["dhcp"]="67"
               ["ftp"]="21"
               ["nfs"]="2049" )

udp_services=( ["dns"]="53" ["dhcp"]="67" )

ip="your.server.ip"

for service in "${!tcp_services[@]}"; do
    port=${tcp_services[$service]}
    timeout 1 bash -c "cat < /dev/null > /dev/tcp/${ip}/${port}" >/dev/null 2>&1
    result=$?
    
    if [ $result -eq 0 ]; then
        echo "TCP $service is open"
    else
        echo "TCP $service is down"
    fi
done

for service in "${!udp_services[@]}"; do
    port=${udp_services[$service]}
    timeout 1 bash -c "cat < /dev/null > /dev/udp/${ip}/${port}" >/dev/null 2>&1
    result=$?
    
    if [ $result -eq 0 ]; then
        echo "UDP $service is open"
    else
        echo "UDP $service is down"
    fi
done
