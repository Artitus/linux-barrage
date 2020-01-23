#!/bin/bash
if $cs_php ; then
    if [ $Distribution = "debian" ]; then
    del /etc/php5/apache2/php.ini
    cp -f ./data/php/debian_php.ini /etc/php5/apache2/php.ini
    chmod 644 /etc/php5/apache2/php.ini
    chown root:root /etc/php5/apache2/php.ini
    elif [ $Distribution = "ubuntu" ]; then
        del /etc/php5/apache2/php.ini
    cp -f ./data/php/ubuntu_php.ini /etc/php5/apache2/php.ini
    chmod 644 /etc/php5/apache2/php.ini
    chown root:root /etc/php5/apache2/php.ini
    else
        error firefox "CONFIG_ERROR: distribution value invalid"
    fi
fi