#!/bin/bash
if $cs_ssh ; then
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
fi