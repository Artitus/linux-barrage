#!/bin/bash
if $cs_mysql ; then
    if [ $Distribution = "debian" ]; then
        del /etc/mysql/my.cnf
        cp -f ./data/mysql/debian_my.cnf /etc/mysql/my.cnf
        chmod 644 /etc/mysql/my.cnf
        chown root:root /etc/mysql/my.cnf
    elif [ $Distribution = "ubuntu" ]; then
        del /etc/mysql/my.cnf
        cp -f ./data/mysql/ubuntu_my.cnf /etc/mysql/my.cnf
        chmod 644 /etc/mysql/my.cnf
        chown root:root /etc/mysql/my.cnf
    else
        error firefox "CONFIG_ERROR: distribution value invalid"
    fi
fi