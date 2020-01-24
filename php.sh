#!/bin/bash
if $cs_php ; then

    if [ $Distribution = "debian" ]; then
        apt -y install php5-common libapache2-mod-php5 php5-cli php5-mysql
        del /etc/php5/apache2/php.ini
        cp -rf ./data/php/debian_php.ini /etc/php5/apache2/php.ini
        chmod 644 /etc/php5/apache2/php.ini
        chown root:root /etc/php5/apache2/php.ini
    elif [ $Distribution = "ubuntu" ]; then
        apt -y install php5 libapache2-mod-php5 php5-mcrypt php5-mysql
        del /etc/php5/apache2/php.ini
        cp -rf ./data/php/ubuntu_php.ini /etc/php5/apache2/php.ini
        chmod 644 /etc/php5/apache2/php.ini
        chown root:root /etc/php5/apache2/php.ini
    else
        error firefox "CONFIG_ERROR: distribution value invalid"
    fi
fi