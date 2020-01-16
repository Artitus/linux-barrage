#!/bin/bash

# Print current users to a file

cut -d: -f1,3 /etc/passwd | egrep ':[0-9]{4}$' | cut -d: -f1 >> ./log/user-list

# TODO If have time automate users ??? Probably not.

# TODO The rest of this file


# Disallow guest
# LOOKUP guest on debian ??? I don't think there is one at all

if [ $Distribution = "debian" ]; then

elif [ $Distribution = "ubuntu" ]; then
    cp -f ./data/user/lightdm.conf /etc/lightdm/
    log user "SUCCESS: Copied custom lightdm configuration"
    if [ -d "/etc/lightdm/lightdm.conf.d/"]; then
        rm -rf /etc/lightdm/lightdm.conf.d/
        log user "SUCCESS: removed /etc/lightdm/lightdm.conf.d/ dir"
    fi
    if [ -d "/usr/share/lightdm/lightdm.conf.d/"]; then
        rm -rf /usr/share/lightdm/lightdm.conf.d/
        log user "SUCCESS: removed /usr/share/lightdm/lightdm.conf.d dir"
    fi
    # Restart LightDM
    # LOOKUP Any way to do this without the script exiting? The settings take effect upon reboot anyway...
else
    error user "CONFIG_ERROR: distribution value invalid"
fi

# Disallow root
passwd -l root
log user "SUCCESS: root locked"
usermod -s /sbin/nologin root
log user "SUCCESS: root shell changed to nologin"

for $u in $(cat ./log/user-list)
do
    usermod -s /bin/bash $u
    log user "SUCCESS: $u shell set to /bin/bash"
    passwd -u $u
    log user "SUCCESS: $u unlocked"

    # TODO Groups

    chmod 750 /home/$u/
    log user "SUCCESS: $u home dir perms set to 750"
    chage -m 5 -M 90 -W 7 $u
    log user "SUCCESS: $u password expiration set"
    passwd --expire $u
    log user "SUCCESS: $u password required to be changed at next login"
done