#!/bin/bash

# FIX This shit doesn't run on Debian, find out why it errors!!!

# Distribution refers to which version of linux you are on, ubuntu or debian
Distribution=

# Did you finish the config?
Configured=false

## Critical Services (true/false)
cs_apache=false
cs_bind9=false
cs_mysql=false
cs_php=false
cs_samba=false
cs_ssh=false

## User Options

# Main user (The user that you started as)
UserName=

# Default password for all users that do not have a password override
UserCommonPassword="B4rr4t3dUs3r-5229"

# Should the script clear the users' home directories
ClearHomeDirectories=true

# Should the script automatically disable/delete user accounts
AutoManageUserAccounts=false

# All users that are allowed to exist on the system
AllowedStandardUsers=(

) # Example Entry: MyUser

# All administrators that are allowed to exist on the system and their respective passwords
declare -A AllowedAdmins=(

) # Example Entry: ["MyAdmin"]="MyPassword"

## Critical Service: bind9

zone="blue.shrek"
local_ip=
# Depending on the network may be 2 or 3 octals (First in reverse order)
reverse_zone_octals=
# Depending on the network may be 1 or 2 octals (Last)
octal=