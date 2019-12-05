#!/bin/bash

# Repair backlight
sed -i '9s/^/#\ /' /etc/default/grub
sed -i '9a GRUB_CMDLINE_LINUX_DEFAULT="quiet acpi_backlight=vendor"' /etc/default/grub

# ignore Handle Lid Switch (ACPI)
sed -i '24s/^/#/' /etc/systemd/logind.conf
sed -i '24a HandleLidSwitch=ignore' /etc/systemd/logind.conf

# disable buzzer
sed -i '$a blacklist pcspkr' /etc/modprobe.d/pve-blacklist.conf

# sync time
# cp /etc/systemd/timesyncd.conf /etc/systemd/timesyncd.conf_bak
# sed -i '$a NTP=192.168.18.200' /etc/systemd/timesyncd.conf
# /bin/systemctl restart systemd-timesyncd.service

sed -i '1s/^/#\ /' /etc/apt/sources.list.d/pve-enterprise.list
mv /etc/apt/sources.list /etc/apt/sources.list.bak
cat > /etc/apt/sources.list << EOF
deb http://ftp.debian.org/debian stretch main contrib

# PVE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve stretch pve-no-subscription

# security updates
deb http://security.debian.org stretch/updates main contrib
EOF

/bin/systemctl stop pve-daily-update.timer
/bin/systemctl disable pve-daily-update.timer
/usr/sbin/update-grub

