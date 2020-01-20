#!/bin/bash

source ./__config.sh
source ./__util.sh

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

# LOOKUP is there a setting to require password every time for sudo?

# LOOKUP http://docs.hardentheworld.org/

# TODO new run system

order=(
    update.sh
    audit.sh
    user.sh
    firefox.sh
    media.sh
    hacktools.sh
    misc.sh
    # bind9.sh
)

for module in "${order[@]}"
do
    . $module
done


#
# * Test out tmuxinator for running scripts in paralell because that would be cool as fuck
# ** https://github.com/tmuxinator/tmuxinator

# sudo apt install tmuxinator