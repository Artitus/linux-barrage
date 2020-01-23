#!/bin/bash
if $cs_apache ; then
    if [ $Distribution = "debian" ]; then
    del /etc/apache2/apache2.conf
    cp -f ./data/apache/debian_apache2.conf /etc/apache2/apache2.conf
    chmod 644 /etc/apache2/apache2.conf
    chown root:root /etc/mysql/my.cnf
    elif [ $Distribution = "ubuntu" ]; then
        del /etc/apache2/apache2.conf
    cp -f ./data/apache/ubuntu_apache2.conf /etc/apache2/apache2.conf
    chmod 644 /etc/apache2/apache2.conf
    chown root:root /etc/mysql/my.cnf
    else
        error firefox "CONFIG_ERROR: distribution value invalid"
    fi
fi