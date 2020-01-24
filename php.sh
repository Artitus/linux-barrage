#!/bin/bash
if $cs_php ; then

    apt install -y php libapache2-mod-php php-mysql

    if [ $Distribution = "debian" ]; then
    del /etc/php5/apache2/php.ini
    cp -rf ./data/php/debian_php.ini /etc/php5/apache2/php.ini
    chmod 644 /etc/php5/apache2/php.ini
    chown root:root /etc/php5/apache2/php.ini
    elif [ $Distribution = "ubuntu" ]; then
        del /etc/php5/apache2/php.ini
    cp -rf ./data/php/ubuntu_php.ini /etc/php5/apache2/php.ini
    chmod 644 /etc/php5/apache2/php.ini
    chown root:root /etc/php5/apache2/php.ini
    else
        error firefox "CONFIG_ERROR: distribution value invalid"
    fi
fi