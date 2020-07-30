#!/bin/bash

# WLAN driver
sudo pacman -S broadcom-wl

#tools
sudo pacman -S htop neofetchq wireless_tools net-tools

#creat VLAN
nm-connection-editor

# Disable Macbook S/PDIF
sudo alsamix

#install zRAM
sudo pamac install systemd-swap
sudo systemctl enable systemd-swap.service
sudo nano /etc/systemd/swap.conf

zswap_enabled=0
zram_size=$(( RAM_SIZE ))
swapfc_enabled=1


# Change swappiness for SSD
cat /proc/sys/vm/swappiness
cat /proc/sys/vm/vfs_cache_pressure
sudo sysctl vm.swappiness=10
