#!/bin/bash

# Iterate through all users
for u in $(cat log/user-list)
do
    # Ensure mozilla dir exists before changing it
    if [ -d "/home/$u/.mozilla/" ]; then
        ## Get all the available firefox profiles for each user
        grep 'Path=' /home/$u/.mozilla/firefox/profiles.ini | sed s/^Path=// > firefox_temp
        for p in $(cat ./firefox_temp)
        do
            ## Copy file
            cp -rf ./data/firefox/user.js /home/$u/.mozilla/firefox/$p/
            log firefox "SUCCESS: $u dir /home/$u/.mozilla/firefox/$p"

            ## Ensure touched files have correct perms
            chmod -R 700 /home/$u/.mozilla/*
            log firefox "SUCCESS: $u mozilla dir perms set to 700"
            chown -R $u:$u /home/$u/.mozilla/
            log firefox "SUCCESS: $u mozilla dir owner set to $u:$u"
        done
        rm -rf ./firefox_temp
    fi
done

# Set global prefs for firefox
if [ $Distribution = "debian" ]; then
    cp ./data/firefox/debiabn_locked.js /etc/firefox-esr/firefox-esr.js
    log firefox "SUCCESS: Global prefs set"

    # Ensure file/folder perms
    chmod -R 644 /etc/firefox-esr/
    log firefox "SUCCESS: Firefox global conf perms set to 644"
    chown -R root:root /etc/firefox-esr/
    log firefox "SUCCESS: Firefox global conf owner set to root"

    # Restart firefox so that all prefs are enabled
    killall firefox &> /dev/null
    log firefox "SUCCESS: Firefox killed"
elif [ $Distribution = "ubuntu" ]; then
    cp ./data/firefox/locked_user.js /etc/firefox/syspref.js
    log firefox "SUCCESS: Global prefs set"

    # Ensure file/folder perms
    chmod -R 644 /etc/firefox-esr/
    log firefox "SUCCESS: Firefox global conf perms set to 644"
    chown -R root:root /etc/firefox-esr/
    log firefox "SUCCESS: Firefox global conf owner set to root"

    # Restart firefox so that all prefs are enabled
    killall firefox &> /dev/null
    log firefox "SUCCESS: Firefox killed"
else
    error firefox "CONFIG_ERROR: distribution value invalid"
fi