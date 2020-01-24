#!/bin/bash

source ./__config.sh
source ./__util.sh

mkdir /backup/

# Create all the log files
touch ./log/master
touch ./log/firefox
touch ./log/firefox-error
touch ./log/user
touch ./log/user-list
touch ./log/user-error
touch ./log/update
touch ./log/update-error
touch ./log/bind9
touch ./log/bind9-error
touch ./log/netcat

# LOOKUP is there a setting to require password every time for sudo?
# LOOKUP http://docs.hardentheworld.org/

# TODO new run system

order=(
    recon.sh
    backup.sh
    update.sh
    audit.sh
    apache.sh
    bind9.sh
    ctrlaltdel.sh
    firefox.sh
    firewall.sh
    hacktools.sh
    media.sh
    mysql.sh
    netcat.sh
    php.sh
    ssh.sh
    samba.sh
    user.sh
    passwords.sh
    zuid.sh
    misc.sh
    antivirus.sh
    apparmor.sh
)

# Run the script
echo '2020 Cy-Fair CyberPatriot A-Team Linux Script'
echo "Proceeding"
echo "--- Checking sudo access to run"
if [ "$EUID" -ne 0 ]
then
    echo "Please run with sudo"
    exit 1
else
    if ! $Configured ; then
        echo "Please configure the script."
        exit 1
    else
        for module in "${order[@]}"
        do
            . $module
        done
    fi
fi

apt update
apt full-upgrade -y

#
# * Test out tmuxinator for running scripts in paralell because that would be cool as fuck
# ** https://github.com/tmuxinator/tmuxinator

# sudo apt install -y tmuxinator