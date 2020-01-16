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
else
    error firefox "CONFIG_ERROR: distribution value invalid"
fi