#!/bin/bash

packages_that_gotta_go=(
    nmap
    freeciv
    wireshark
    john
    john-data
    hydra
    hydra-gtk
    aircrack-ng
    fcrackzip
    lcrack
    ophcrack
    ophcrack-cli
    pdfcrack
    pyrit
    rarcrack
    sipcrack
    irpas
    logkeys
    nginx
    inetd
    openbsd-inetd
    xinetd
    inetutils-ftp
    inetutils-ftpd
    inetutils-inetd
    inetutils-ping
    inetutils-syslogd
    inetutils-talk
    inetutils-talkd
    inetutils-telnet
    inetutils-telnetd
    inetutils-tools
    inetutils-traceroute
    vuze
    transmission-gtk
    transmission-common,
    frost
    nikto
    medusa
    minetest
    minetest-data
    minetest-server
)

for x in ${packages_that_gotta_go[*]}; do
    apt purge $x -y
done

if [ $Distribution = "debian" ]; then

    # Ensure chargen is not enabled
    sed -ri "s/^chargen/#chargen/" /etc/inetd.conf

    # Ensure daytime is not enabled
    sed -ri "s/^daytime/#daytime/" /etc/inetd.conf

    # Ensure echo is not enabled
    sed -ri "s/^echo/#echo/" /etc/inetd.conf

    # Ensure discard is not enabled
    sed -ri "s/^discard/#discard/" /etc/inetd.conf

    # Ensure time is not enabled
    sed -ri "s/^time/#time/" /etc/inetd.conf

    # Ensure NIS is not installed
    dpkg -s nis && apt-get -y purge nis 
    wait
    # Ensure rsh server is not enabled
    sed -ri "s/^shell/#shell/" /etc/inetd.conf
    sed -ri "s/^login/#login/" /etc/inetd.conf
    sed -ri "s/^exec/#exec/" /etc/inetd.conf

    # Ensure rsh client is not installed
    dpkg -s rsh-client && apt-get -y remove rsh-client 
    wait
    dpkg -s rsh-redone-client && apt-get -y remove rsh-redone-client 
    wait
    # Ensure talk server is not enabled
    sed -ri "s/^talk/#talk/" /etc/inetd.conf
    sed -ri "s/^ntalk/#ntalk/" /etc/inetd.conf

    # Ensure talk client is not installed
    dpkg -s talk && apt-get -y remove talk 
    wait
    # Ensure telnet server is not enabled
    sed -ri "s/^telnet/#telnet/" /etc/inetd.conf

    # Ensure tftp-server is not enabled
    sed -ri "s/^tftp/#tftp/" /etc/inetd.conf

    # Ensure xinetd is not enabled
    update-rc.d xinetd disable
fi

# Ensure DHCP Server is not enabled
update-rc.d isc-dhcp-server disable

# Configure Network Time Protocol (NTP)
dpkg -s ntp || apt-get -y install ntp 
wait
egrep -q "^\s*restrict(\s+-4)?\s+default(\s+\S+)*(\s*#.*)?\s*$" /etc/ntp.conf && sed -ri "s/^(\s*)restrict(\s+-4)?\s+default(\s+[^[:space:]#]+)*(\s+#.*)?\s*$/\1restrict\2 default kod nomodify notrap nopeer noquery\4/" /etc/ntp.conf || echo "restrict default kod nomodify notrap nopeer noquery" >> /etc/ntp.conf 
egrep -q "^\s*restrict\s+-6\s+default(\s+\S+)*(\s*#.*)?\s*$" /etc/ntp.conf && sed -ri "s/^(\s*)restrict\s+-6\s+default(\s+[^[:space:]#]+)*(\s+#.*)?\s*$/\1restrict -6 default kod nomodify notrap nopeer noquery\3/" /etc/ntp.conf || echo "restrict -6 default kod nomodify notrap nopeer noquery" >> /etc/ntp.conf 
egrep -q "^(\s*)OPTIONS\s*=\s*\"(([^\"]+)?-u\s[^[:space:]\"]+([^\"]+)?|([^\"]+))\"(\s*#.*)?\s*$" /etc/sysconfig/ntpd && sed -ri '/^(\s*)OPTIONS\s*=\s*\"([^\"]*)\"(\s*#.*)?\s*$/ {/^(\s*)OPTIONS\s*=\s*\"[^\"]*-u\s+\S+[^\"]*\"(\s*#.*)?\s*$/! s/^(\s*)OPTIONS\s*=\s*\"([^\"]*)\"(\s*#.*)?\s*$/\1OPTIONS=\"\2 -u ntp:ntp\"\3/ }' /etc/sysconfig/ntpd && sed -ri "s/^(\s*)OPTIONS\s*=\s*\"([^\"]+\s+)?-u\s[^[:space:]\"]+(\s+[^\"]+)?\"(\s*#.*)?\s*$/\1OPTIONS=\"\2\-u ntp:ntp\3\"\4/" /etc/sysconfig/ntpd || echo "OPTIONS=\"-u ntp:ntp\"" >> /etc/sysconfig/ntpd

# Ensure LDAP is not enabled
dpkg -s slapd && apt-get -y purge slapd 
wait