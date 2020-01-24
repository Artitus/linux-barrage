#!/bin/bash

if $cs_samba ; then

    apt install -y samba

    if [ $Distribution = "debian" ]; then
        del /etc/samba/*
        cp -rf ./data/samba/debian/* /etc/samba/
    elif [ $Distribution = "ubuntu" ]; then
        del /etc/samba/*
        cp -rf ./data/samba/ubuntu/* /etc/samba/
    else
        error firefox "CONFIG_ERROR: distribution value invalid"
    fi

fi