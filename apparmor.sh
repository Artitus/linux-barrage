#!/bin/bash

# TODO finish

apt install -y apparmor

if ! grep 'pam_apparmor.so order=user,group,default' /etc/pam.d/*; then
    echo 'session optional pam_apparmor.so order=user,group,default' > /etc/pam.d/apparmor
fi

find /etc/apparmor.d/ -maxdepth 1 -type f -exec aa-enforce {} \; 
aa-complain /etc/apparmor.d/usr.sbin.rsyslogd 