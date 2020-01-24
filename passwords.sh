#!/bin/bash

apt install -y libpam-modules

del /etc/pam.d/common-auth
del /etc/pam.d/common-password

cp -f ./data/passwords/common-auth /etc/pam.d/common-auth
cp -f ./data/passwords/common-password /etc/pam.d/common-password

del /etc/login.defs
cp -f ./data/passwords/login.defs /etc/login.defs