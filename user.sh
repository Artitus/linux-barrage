#!/bin/bash

# Print current users to a file

cut -d: -f1,3 /etc/passwd | egrep ':[0-9]{4}$' | cut -d: -f1 >> ./log/user-list

# TONOT If have time automate users ??? Probably not.


# Disallow guest
if [ $Distribution = "debian" ]; then
    # Check if lightdm dir exists
    if [ -d "/etc/lightdm/" ]; then
        cp -rf ./data/user/lightdm.conf /etc/lightdm/
        log user "SUCCESS: Copied custom lightdm configuration"
    else
        log user "INFO: /etc/lightdm/ did not eixst"
    fi
    if [ -d "/etc/lightdm/lightdm.conf.d/" ]; then
        del "/etc/lightdm/lightdm.conf.d/"
        log user "SUCCESS: removed /etc/lightdm/lightdm.conf.d/ dir"
    else
        log user "INFO: /etc/lightdm/lightdm.conf.d/ did not eixst"
    fi
    if [ -d "/usr/share/lightdm/lightdm.conf.d/" ]; then
        del "/usr/share/lightdm/lightdm.conf.d/"
        log user "SUCCESS: removed /usr/share/lightdm/lightdm.conf.d dir"
    else
        log user "INFO: /usr/share/lightdm/ did not eixst"
    fi
    # Restart LightDM
    # LOOKUP Any way to do this without the script exiting? The settings take effect upon reboot anyway...
elif [ $Distribution = "ubuntu" ]; then

    cp -rf ./data/user/lightdm.conf /etc/lightdm/
    log user "SUCCESS: Copied custom lightdm configuration"
    if [ -d "/etc/lightdm/lightdm.conf.d/" ]; then
        del "/etc/lightdm/lightdm.conf.d/"
        log user "SUCCESS: removed /etc/lightdm/lightdm.conf.d/ dir"
    fi
    if [ -d "/usr/share/lightdm/lightdm.conf.d/" ]; then
        del "/usr/share/lightdm/lightdm.conf.d/"
        log user "SUCCESS: removed /usr/share/lightdm/lightdm.conf.d dir"
    fi
    # Restart LightDM ## See above
else
    error user "CONFIG_ERROR: distribution value invalid"
fi

# Disallow root
passwd -l root
log user "SUCCESS: root locked"
usermod -s /sbin/nologin root
log user "SUCCESS: root shell changed to nologin"

for u in $(cat ./log/user-list)
do

    if [ ! "$u" = "$UserName" ]; then
        for file in $(ls -A1 /home/$u/); do mv "$file" "_$file"; done;
    fi

    echo -e "$UserCommonPassword\n$UserCommonPassword" | passwd $u
    log user "SUCCESS: $u password set to $UserCommonPassword"

    usermod -s /bin/bash $u
    log user "SUCCESS: $u shell set to /bin/bash"
    passwd -u $u
    log user "SUCCESS: $u unlocked"

    # TONOT Groups

    chmod 750 /home/$u/
    log user "SUCCESS: $u home dir perms set to 750"
    chage -m 5 -M 90 -W 7 $u
    log user "SUCCESS: $u password expiration set"
    passwd --expire $u
    log user "SUCCESS: $u password required to be changed at next login"

    chmod 640 /home/$u/.bash_history

done

# Harden sudoers
if [ $Distribution = "debian" ]; then
    visudo -q -c -s -f ./data/user/debian-sudoers
elif [ $Distribution = "ubuntu" ]; then
    visudo -q -c -s -f ./data/user/ubuntu-sudoers
else
    error firefox "CONFIG_ERROR: distribution value invalid"
fi