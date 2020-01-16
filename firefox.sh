#!/bin/bash

# Iterate through all users
for u in $(cat log/user-list)
do
    ## Get all the available firefox profiles for each user
    grep 'Path=' /home/$u/.mozilla/firefox/profiles.ini | sed s/^Path=// > temp_profiles
    for p in $(cat ./temp_profiles)
    do
        ## Copy file
        cp ./data/firefox/user.js /home/$u/.mozilla/firefox/$p/
        log firefox "SUCCESS: $u dir /home/$u/.mozilla/firefox/$p"
    done
    rm -rf ./temp_profiles
done

# Set global prefs for firefox
if [ $distribution = "debian" ]; then
    cp ./data/firefox/debiabn_locked.js /etc/firefox-esr/firefox-esr.js
    log firefox "SUCCESS: Global prefs set"
elif [ $distribution = "ubuntu" ]; then
    cp ./data/firefox/locked_user.js /etc/firefox/syspref.js
    log firefox "SUCCESS: Global prefs set"
else
    error firefox "CONFIG_ERROR: distribution value invalid"
fi

# Restart firefox so that all prefs are enabled
killall firefox &> /dev/null
log firefox "SUCCESS: Firefox killed"