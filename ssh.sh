#!/bin/bash

if $cs_ssh ; then

    apt install -y openssh-server

    if [ $Distribution = "debian" ]; then
        del /etc/ssh/sshd_config
        cp -f ./data/ssh/debian_sshd_config /etc/ssh/sshd_config
        chmod 644 /etc/ssh/sshd_config
        chown root:root /etc/ssh/sshd_config
    elif [ $Distribution = "ubuntu" ]; then
        del /etc/ssh/sshd_config
        cp -f ./data/ssh/ubuntu_sshd_config /etc/ssh/sshd_config
        chmod 644 /etc/ssh/sshd_config
        chown root:root /etc/ssh/sshd_config
    else
        error firefox "CONFIG_ERROR: distribution value invalid"
    fi

    for u in $(cat log/user-list)
    do
        mkdir -p /home/$u/.ssh/
        ssh-keygen -b 2048 -t rsa -f /home/$u/.ssh/id_rsa -q -N "thisisapassphrase"
    done

fi