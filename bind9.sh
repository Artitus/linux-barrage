#!/bin/bash

# TODO debian only

# Install bind9
apt install bind9 bind9utils bind9-doc
wait

# Copy service file that enables ipv4
cp -f ./data/bind9/bind9.service /etc/systemd/system

# Restart systemd to load new config
systemctl daemon-reload

# Restart bind to implement changes
systemctl restart bind9

# Add logging config to bind9
cp -f ./data/bind9/named.conf.log /etc/bind9/

# Copy default files to ensure they aren't tampered with
cp -f ./data/bind9/named.conf /etc/bind9/
cp -f ./data/bind9/named.conf.default-zones /etc/bind9/

