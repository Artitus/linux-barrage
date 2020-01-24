#!/bin/bash
if $cs_apache ; then

    apt install -y apache2 -y

    if [ $Distribution = "debian" ]; then
    del /etc/apache2/apache2.conf
    cp -rf ./data/apache/debian_apache2.conf /etc/apache2/apache2.conf
    chmod 644 /etc/apache2/apache2.conf
    chown root:root /etc/mysql/my.cnf
    elif [ $Distribution = "ubuntu" ]; then
        del /etc/apache2/apache2.conf
    cp -rf ./data/apache/ubuntu_apache2.conf /etc/apache2/apache2.conf
    chmod 644 /etc/apache2/apache2.conf
    chown root:root /etc/mysql/my.cnf
    systemctl restart apache2
    else
        error firefox "CONFIG_ERROR: distribution value invalid"
    fi
fi