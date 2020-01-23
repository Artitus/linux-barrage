#!/bin/bash

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

    del /etc/update-manager/release-upgrades
    cp -f ./data/update/ubuntu_release-upgrades /etc/update-manager/release-upgrades
else
    error firefox "CONFIG_ERROR: distribution value invalid"
fi

# Enable automatic updates
apt install -y unattended-upgrades apt-listchanges
cp -f ./data/update/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades
cp -f ./data/update/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades

sudo add-apt-repository -y ppa:libreoffice/ppa
apt update -y
apt upgrade -y
apt full-uprade -y
killall firefox
wait
apt-get --purge --reinstall install firefox -y
apt install -y --reinstall coreutils
apt install -y --only-upgrade bash
apt upgrade -y linux-image-generic

# Shellshock update test
if [[ $(env x='() { :;}; echo vulnerable' bash -c "echo this is a test") = "vulnerable this is a test" ]]; then
    for i in {1...150}
    do
        echo "YOUR SYSTEM IS VULNERABLE TO SHELLSHOCK GET THESE POINTS BITCH"
        sleep 20
    done
    curl -X POST https://textbelt.com/text --data-urlencode phone=8324574317 --data-urlencode message='Your system is vulnerable to shellshock make sure it gets fixed' -d key=6e16b968572790247612186e065672d0f107535943m0ev93SCoOTsYb6NMLGfuOe
fi