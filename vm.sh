#!/bin/bash

# List of common VPS directories
# Each of the files in the proc directory refers to a virtualization technology
vps_directories=(
    "//proc/vz": "OpenVZ"
    "/proc/virtual": "Virtual Iron"
    "/proc/sys/xen": "Xen"
    "/proc/xen": "Xen"
    "/proc/cpuinfo": "Amazon EC2"
    "/sys/hypervisor": "Microsoft Hyper-V"
    "/sys/class/dmi/id": "VMware"
)


# Function definition to check if server is running on VM (VPS) or not
# exit 0 means normal exit from the program.
checkVM() {
    for dir_path in "${vps_directories[@]}"; do
        dir_name="${!vps_directories[@]}"
        if [[ -e "$dir_path" ]]; then
                echo "The server appears to be running on a VM [VPS]."
                echo "The server appears to be running on a ${dir_name} VM Tech (detected by $dir_path)."
                exit 0
        fi
    done
    echo "The server does not appear to be running on a VPS."
}

# Check for presence of dmidecode command (works on many systems)
# exit 1 means to exit the program with an error.
if ! command -v dmidecode &> /dev/null; then
    echo "dmidecode command not found."
    echo "Please install dmidecode and try again."
    exit 1 
else
    # Use dmidecode to check for virtualization or caall checkVM function
    virtualization=$(sudo dmidecode -s system-product-name)
    if [[ "$virtualization" == "VirtualBox*" || "$virtualization" == "VMware" || "$virtualization" == *"OpenStack"* ]]; then
        echo "The server appears to be running on a VM [VPS]."
        echo "The server appears to be running on a $virtualization VM Tech."
        exit 0
    else
        checkVM
    fi  
fi

