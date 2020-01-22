#!/bin/bash

# TODO enable auto updates and set security updates and all that shit

# Clean/audit sources.list
if [ $Distribution = "debian" ]; then
    # Import clean sources.list
    cp -f ./data/update/debian-sources.list /etc/apt/sources.list
    log update "SUCCESS: Clean debian list imported"

    # Clear sources.list.d
    del "/etc/apt/sources.list.d/*"
    log update "SUCCESS: Cleared sources.list.d"
elif [ $Distribution = "ubuntu" ]; then
    # Import clean sources.list
    cp -f ./data/update/ubuntu-sources.list /etc/apt/sources.list
    log update "SUCCESS: Clean ubuntu list imported"

    # Clear sources.list.d
    del "/etc/apt/sources.list.d/*"
    log update "SUCCESS: Cleared sources.list.d"

    # Install unattended upgrades
    apt install -y unattended-upgrades
    # Enable unattended upgrades
    dpkg-reconfigure --priority=low unattended-upgrades # TODO look into

    # Specify security updates
    cp -f ./data/update/50unattended-upgrades /etc/apt/apt.conf.d/


else
    error firefox "CONFIG_ERROR: distribution value invalid"
fi

sudo add-apt-repository -y ppa:libreoffice/ppa
wait
apt update -y
wait
apt upgrade -y
wait
apt full-uprade -y
wait
killall firefox
wait
apt-get --purge --reinstall install firefox -y
wait