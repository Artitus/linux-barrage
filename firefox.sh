#!/bin/bash


## How to get path to put user.js into
# cd ~/.mozilla/firefox/
# if [[ $(grep '\[Profile[^0]\]' profiles.ini) ]]
# then PROFPATH=$(grep -E '^\[Profile|^Path|^Default' profiles.ini | grep -1 '^Default=1' | grep '^Path' | cut -c6-)
# else PROFPATH=$(grep 'Path=' profiles.ini | sed 's/^Path=//')
# fi

# echo $PROFPATH

## FIXME REMOVE AFTER USER SCRIPT IS COMPLETE
cut -d: -f1,3 /etc/passwd | egrep ':[0-9]{4}$' | cut -d: -f1 > ./log/user-list

# Iterate through all users
for u in $(cat log/user-list)
do
    ## Get all the available firefox profiles for each user
    paths=$(grep 'Path=' /home/$u/.mozilla/firefox/profiles.ini | sed s/^Path=//)
    for p in "${paths[@]}"
    do
        ## Copy file
        cp ./data/firefox/user.js /home/$u/.mozilla/firefox/$p/user.js
    done
done

# Set global prefs for firefox


# TODO Locked user.js ???

# TODO If Debian
# FIXME Not debian-locked.js

cp ./data/firefox/systemwide_user.js /etc/firefox-esr/firefox-esr.js

# TODO If Ubuntu
# FIXME syspref.js or firefox.js for Ubuntu 16.04 Firefox?

cp ./data/firefox/systemwide_user.js /etc/firefox/syspref.js