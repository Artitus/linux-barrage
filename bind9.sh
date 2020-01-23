#!/bin/bash

# TODO debian only

if $cs_bind9 ; then

    # Install bind9
    apt install -y bind9
    wait

    # Copy service file that enables ipv4
    cp -f ./data/bind9/bind9 /etc/default/bind9

    # Restart bind to implement changes
    /etc/init.d/bind9 restart

    # Add logging config to bind9
    cp -f ./data/bind9/named.conf.log /etc/bind/

    # Copy default files to ensure they aren't tampered with
    cp -f ./data/bind9/named.conf /etc/bind/
    cp -f ./data/bind9/named.conf.default-zones /etc/bind/

    # Files to set "placeholders" in
    placeholdered_files=(
        named.conf.local
        named.conf.options
        forward
        reverse
    )

    # Set placeholders then copy file to where it should be
    for f in "${placeholdered_files[@]}"
    do
        sed -i "s/%%zone%%/$zone/g" "./data/bind9/$f"
        sed -i "s/%%local_ip%%/$local_ip/g" "./data/bind9/$f"
        sed -i "s/%%octal%%/$octal/g" "./data/bind9/$f"
        sed -i "s/%%reverse_octal%%/$reverse_zone_octals/g" "./data/bind9/$f"

        cp -r "./data/bind9/$f" "/etc/bind/$f"
        log bind9 "SUCCESS: $f copied into /etc/bind9"
    done

    # Restart bind
    /etc/init.d/bind9 restart

fi