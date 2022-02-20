#!/bin/bash

if [ "$#" -eq  "0" ]
  then
    echo -e "ERROR: No arguments supplied, please provide a valid argument:"
    echo -e "> -k,--kill\n\tCuts the gpu power off"
    echo -e "> -s,--start\n\tTurns the gpu power on"
else
    case "$1" in
        -k|--kill )
            # Unload Nvidia Module
            doas modprobe -r nvidia
            doas modprobe -r nvidia_modeset
            # Check if nvidia GPU is being used
                # Load acpi-call-dkms kenrel module
                doas modprobe acpi_call
                # Turn GPU off with acpi_call
            	doas sh -c 'echo "\\_SB.PCI0.GPP0.PG00._OFF" > /proc/acpi/call'
                echo "GPU powered off"
        ;;
        -s|--start )
            # Choose nvidia gpu for graphics
            # Load Nvidia Modules
            doas modprobe nvidia
            doas modprobe nvidia_modeset
            # Load acpi-call-dkms kenrel module
            doas modprobe acpi_call
            # Turn GPU on with acpi_call
            doas sh -c 'echo "\\_SB.PCI0.GPP0.PG00._ON" > /proc/acpi/call'
            echo "GPU powered on"
        ;;
        *)
            echo "Please provide a valid argument:"
            echo -e "> -k,--kill\n\tCuts the gpu power off"
            echo -e "> -s,--start\n\tTurns the gpu power on"
        ;;
    esac
fi




