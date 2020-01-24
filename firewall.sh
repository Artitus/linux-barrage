#!/bin/bash

apt install ufw -y

# Enable firewall
ufw enable
log firewall "UFW enabled"
ufw logging on
log firewall "UFW Logging on"
ufw logging high
log firewall "UFW Logging high"

ufw default deny incoming
log firewall "UFW Deny incoming"
ufw default allow outgoing
log firewall "UFW Allow outgoing"

if $cs_apache ; then
    ufw allow proto tcp from any to any port 80,443
    log firewall "UFW Allow apache"
fi

if $cs_bind9 ; then
    ufw allow 53/tcp
    ufw allow 53/udp
    log firewall "UFW Allow bind9"
fi

if $cs_mysql ; then
    ufw allow 3306
    log firewall "UFW Allow mysql"
fi

if $cs_samba ; then
    ufw allow proto tcp from any to any port 139,445
    ufw allow proto udp from any to any port 137,138
    log firewall "UFW Allow samba"
fi

if $cs_ssh ; then
    ufw allow ssh
    log firewall "UFW Allow ssh"
fi