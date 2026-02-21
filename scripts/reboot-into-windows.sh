#!/usr/bin/env bash

# Get the Windows menu entry from GRUB
windows_entry=$(grep -i "windows" /boot/grub/grub.cfg | grep menuentry | cut -d "'" -f2 | head -n 1)

if [ -z "$windows_entry" ]; then
    echo "Error: Windows entry not found in GRUB configuration"
    exit 1
fi

# Set the next boot to Windows and reboot
sudo grub-reboot "$windows_entry" 
reboot
