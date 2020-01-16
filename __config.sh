#!/bin/bash

# Distribution refers to which version of linux you are on, Ubuntu or Debian
Distribution=debian

## User Options

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