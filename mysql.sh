#!/bin/bash
if $cs_mysql ; then

    debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
    debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
    apt -y install mysql-server

    if [ $Distribution = "debian" ]; then
        del /etc/mysql/my.cnf
        cp -rf ./data/mysql/debian_my.cnf /etc/mysql/my.cnf
        chmod 644 /etc/mysql/my.cnf
        chown root:root /etc/mysql/my.cnf
    elif [ $Distribution = "ubuntu" ]; then
        del /etc/mysql/my.cnf
        cp -rf ./data/mysql/ubuntu_my.cnf /etc/mysql/my.cnf
        chmod 644 /etc/mysql/my.cnf
        chown root:root /etc/mysql/my.cnf
    else
        error firefox "CONFIG_ERROR: distribution value invalid"
    fi
fi