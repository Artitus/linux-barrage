#!/bin/bash

source ./__config.sh
source ./__util.sh

# Create all the log files
touch ./log/master
touch ./log/firefox
touch ./log/firefox-error
touch ./log/user-list
touch ./log/user
touch ./log/user-error

# LOOKUP require password every time for sudo

order=(
    user.sh
    firefox.sh
)

for module in "${order[@]}"
do
    . $module
done