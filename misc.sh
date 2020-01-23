#!/bin/bash

del /etc/sysctl.conf
cp -f ./data/sysctl/sysctl.conf /etc/sysctl.conf

unalias -a
dpkg-statoverride --update --add root sudo 4750 /bin/su

# Disable IP Forwarding
egrep -q "^(\s*)net.ipv4.ip_forward\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.ip_forward\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.ip_forward = 0\2/" /etc/sysctl.conf || echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf

# Disable Send Packet Redirects
egrep -q "^(\s*)net.ipv4.conf.all.send_redirects\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.all.send_redirects\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.all.send_redirects = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf
egrep -q "^(\s*)net.ipv4.conf.default.send_redirects\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.default.send_redirects\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.default.send_redirects = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.default.send_redirects = 0" >> /etc/sysctl.conf

# Disable Source Routed Packet Acceptance
egrep -q "^(\s*)net.ipv4.conf.all.accept_source_route\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.all.accept_source_route\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.all.accept_source_route = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
egrep -q "^(\s*)net.ipv4.conf.default.accept_source_route\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.default.accept_source_route\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.default.accept_source_route = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf

# Disable ICMP Redirect Acceptance
egrep -q "^(\s*)net.ipv4.conf.all.accept_redirects\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.all.accept_redirects\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.all.accept_redirects = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
egrep -q "^(\s*)net.ipv4.conf.default.accept_redirects\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.default.accept_redirects\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.default.accept_redirects = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.default.accept_redirects = 0" >> /etc/sysctl.conf

# Disable Secure ICMP Redirect Acceptance
egrep -q "^(\s*)net.ipv4.conf.all.secure_redirects\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.all.secure_redirects\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.all.secure_redirects = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.all.secure_redirects = 0" >> /etc/sysctl.conf
egrep -q "^(\s*)net.ipv4.conf.default.secure_redirects\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.default.secure_redirects\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.default.secure_redirects = 0\2/" /etc/sysctl.conf || echo "net.ipv4.conf.default.secure_redirects = 0" >> /etc/sysctl.conf

# Log Suspicious Packets
egrep -q "^(\s*)net.ipv4.conf.all.log_martians\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.all.log_martians\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.all.log_martians = 1\2/" /etc/sysctl.conf || echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
egrep -q "^(\s*)net.ipv4.conf.default.log_martians\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.default.log_martians\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.default.log_martians = 1\2/" /etc/sysctl.conf || echo "net.ipv4.conf.default.log_martians = 1" >> /etc/sysctl.conf

# Enable Ignore Broadcast Requests
egrep -q "^(\s*)net.ipv4.icmp_echo_ignore_broadcasts\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.icmp_echo_ignore_broadcasts\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.icmp_echo_ignore_broadcasts = 1\2/" /etc/sysctl.conf || echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf

# Enable Bad Error Message Protection
egrep -q "^(\s*)net.ipv4.icmp_ignore_bogus_error_responses\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.icmp_ignore_bogus_error_responses\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.icmp_ignore_bogus_error_responses = 1\2/" /etc/sysctl.conf || echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> /etc/sysctl.conf

# Enable RFC-recommended Source Route Validation
egrep -q "^(\s*)net.ipv4.conf.all.rp_filter\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.all.rp_filter\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.all.rp_filter = 1\2/" /etc/sysctl.conf || echo "net.ipv4.conf.all.rp_filter = 1" >> /etc/sysctl.conf
egrep -q "^(\s*)net.ipv4.conf.default.rp_filter\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.conf.default.rp_filter\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.conf.default.rp_filter = 1\2/" /etc/sysctl.conf || echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf

# Enable TCP SYN Cookies
egrep -q "^(\s*)net.ipv4.tcp_syncookies\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)net.ipv4.tcp_syncookies\s*=\s*\S+(\s*#.*)?\s*$/\1net.ipv4.tcp_syncookies = 1\2/" /etc/sysctl.conf || echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf

# Install TCP Wrappers
dpkg -s tcpd || apt-get -y install tcpd 
wait
# Verify Permissions on /etc/hosts.allow
chmod u+r+w-x,g+r-w-x,o+r-w-x /etc/hosts.allow 

# Verify Permissions on /etc/hosts.deny
chmod u+r+w-x,g+r-w-x,o+r-w-x /etc/hosts.deny 

# Install the rsyslog package
dpkg -s rsyslog || apt-get -y install rsyslog 
wait
# Ensure the rsyslog Service is activated
systemctl enable rsyslog 

# Enable cron Daemon
systemctl enable cron 
systemctl enable anacron 

# Set User/Group Owner and Permission on /etc/crontab
chmod g-r-w-x,o-r-w-x /etc/crontab 
chown 0:0 /etc/crontab 

# Set User/Group Owner and Permission on /etc/cron.hourly
chmod g-r-w-x,o-r-w-x /etc/cron.hourly/ 
chown 0:0 /etc/cron.hourly/ 

# Set User/Group Owner and Permission on /etc/cron.daily
chmod g-r-w-x,o-r-w-x /etc/cron.daily/ 
chown 0:0 /etc/cron.daily/ 

# Set User/Group Owner and Permission on /etc/cron.weekly
chmod g-r-w-x,o-r-w-x /etc/cron.weekly/ 
chown 0:0 /etc/cron.weekly/ 

# Set User/Group Owner and Permission on /etc/cron.monthly
chmod g-r-w-x,o-r-w-x /etc/cron.monthly/ 
chown 0:0 /etc/cron.monthly/ 

# Set User/Group Owner and Permission on /etc/cron.d
chmod g-r-w-x,o-r-w-x /etc/cron.d/ 
chown 0:0 /etc/cron.d/ 

# Restrict at/cron to Authorized Users
rm -rf /etc/cron.deny 
touch /etc/cron.allow 
chmod g-r-w-x,o-r-w-x /etc/cron.allow 
chown 0:0 /etc/cron.allow 
rm -rf /etc/at.deny 
touch /etc/at.allow 
chmod g-r-w-x,o-r-w-x /etc/at.allow 
chown 0:0 /etc/at.allow 

sed -i 's/^#cron./cron./' /etc/rsyslog.d/50-default.conf

crontab -r 
cd /etc/ 
/bin/rm -f cron.deny at.deny 
echo root > cron.allow
echo root > at.allow
/bin/chown root:root cron.allow at.allow 
/bin/chmod 644 cron.allow at.allow 

# Disable System Accounts
for user in `awk -F: '($3 < 1000) {print $1 }' /etc/passwd`; do
if [ $user != "root" ]
then
/usr/sbin/usermod -L $user 
if [ $user != "sync" ] && [ $user != "shutdown" ] && [ $user != "halt" ]
then
    /usr/sbin/usermod -s /usr/sbin/nologin $user 
fi
fi
done

# Disable login for root user
/usr/sbin/usermod -s /usr/sbin/nologin root 

# Set Default Group for root Account
usermod -g 0 root 

# Set Default umask for Users
egrep -q "^(\s*)umask\s+\S+(\s*#.*)?\s*$" /etc/bash.bashrc && sed -ri "s/^(\s*)umask\s+\S+(\s*#.*)?\s*$/\1umask 077\2/" /etc/bash.bashrc || echo "umask 077" >> /etc/bash.bashrc
egrep -q "^(\s*)umask\s+\S+(\s*#.*)?\s*$" /etc/profile.d/cis.sh && sed -ri "s/^(\s*)umask\s+\S+(\s*#.*)?\s*$/\1umask 077\2/" /etc/profile.d/cis.sh || echo "umask 077" >> /etc/profile.d/cis.sh

# Set Warning Banner for Standard Login Services
chmod u+r+w-x,g+r-w-x,o+r-w-x /etc/motd 
chown 0:0 /etc/motd 
chmod u+r+w-x,g+r-w-x,o+r-w-x /etc/issue 
chown 0:0 /etc/issue 
chmod u+r+w-x,g+r-w-x,o+r-w-x /etc/issue.net 
chown 0:0 /etc/issue.net 

# Remove OS Information from Login Warning Banners
sed -ri 's/(\\v|\\r|\\m|\\s)//g' /etc/issue
sed -ri 's/(\\v|\\r|\\m|\\s)//g' /etc/issue.net
sed -ri 's/(\\v|\\r|\\m|\\s)//g' /etc/motd

# Verify Permissions on /etc/passwd
chmod u+r+w-x,g+r-w-x,o+r-w-x /etc/passwd 

# Verify Permissions on /etc/shadow
chmod u+r+w-x,g+r-w-x,o-r-w-x /etc/shadow 

# Verify Permissions on /etc/group
chmod u+r+w-x,g+r-w-x,o+r-w-x /etc/group 

# Verify User/Group Ownership on /etc/passwd
chown 0:0 /etc/passwd 

# Verify User/Group Ownership on /etc/shadow
chown 0:42 /etc/shadow 

# Verify User/Group Ownership on /etc/group
chown 0:0 /etc/group 

# Verify No Legacy &quot;+&quot; Entries Exist in /etc/passwd File
sed -ri '/^\+:.*$/ d' /etc/passwd

# Verify No Legacy &quot;+&quot; Entries Exist in /etc/shadow File
sed -ri '/^\+:.*$/ d' /etc/shadow

# Verify No Legacy &quot;+&quot; Entries Exist in /etc/group File
sed -ri '/^\+:.*$/ d' /etc/group

chmod 640 .bash_history 

find /bin/ -name "*.sh" -type f -delete

# Set nodev option for /tmp Partition
egrep -q "^(\s*\S+\s+)/tmp(\s+\S+\s+\S+)(\s+\S+\s+\S+)(\s*#.*)?\s*$" /etc/fstab && sed -ri "s/^(\s*\S+\s+)/tmp(\s+\S+\s+\S+)(\s+\S+\s+\S+)(\s*#.*)?\s*$/\1/tmp\2nodev\3\4/" /etc/fstab

# Set nosuid option for /tmp Partition
egrep -q "^(\s*\S+\s+)/tmp(\s+\S+\s+\S+)(\s+\S+\s+\S+)(\s*#.*)?\s*$" /etc/fstab && sed -ri "s/^(\s*\S+\s+)/tmp(\s+\S+\s+\S+)(\s+\S+\s+\S+)(\s*#.*)?\s*$/\1/tmp\2nosuid\3\4/" /etc/fstab

egrep -q "^(\s*\S+\s+)/tmp(\s+\S+\s+\S+)(\s+\S+\s+\S+)(\s*#.*)?\s*$" /etc/fstab && sed -ri "s/^(\s*\S+\s+)/tmp(\s+\S+\s+\S+)(\s+\S+\s+\S+)(\s*#.*)?\s*$/\1/tmp\2noexec\3\4/" /etc/fstab

# Add nodev Option to /home
egrep -q "^(\s*\S+\s+)/home(\s+\S+\s+\S+)(\s+\S+\s+\S+)(\s*#.*)?\s*$" /etc/fstab && sed -ri "s/^(\s*\S+\s+)/home(\s+\S+\s+\S+)(\s+\S+\s+\S+)(\s*#.*)?\s*$/\1/home\2nodev\3\4/" /etc/fstab

# Add nodev Option to /run/shm Partition
egrep -q "^(\s*\S+\s+)/run/shm(\s+\S+\s+\S+)(\s+\S+\s+\S+)(\s*#.*)?\s*$" /etc/fstab && sed -ri "s/^(\s*\S+\s+)/run/shm(\s+\S+\s+\S+)(\s+\S+\s+\S+)(\s*#.*)?\s*$/\1/run/shm\2nodev\3\4/" /etc/fstab

# Add nosuid Option to /run/shm Partition
egrep -q "^(\s*\S+\s+)/run/shm(\s+\S+\s+\S+)(\s+\S+\s+\S+)(\s*#.*)?\s*$" /etc/fstab && sed -ri "s/^(\s*\S+\s+)/run/shm(\s+\S+\s+\S+)(\s+\S+\s+\S+)(\s*#.*)?\s*$/\1/run/shm\2nosuid\3\4/" /etc/fstab

# Add noexec Option to /run/shm Partition
egrep -q "^(\s*\S+\s+)/run/shm(\s+\S+\s+\S+)(\s+\S+\s+\S+)(\s*#.*)?\s*$" /etc/fstab && sed -ri "s/^(\s*\S+\s+)/run/shm(\s+\S+\s+\S+)(\s+\S+\s+\S+)(\s*#.*)?\s*$/\1/run/shm\2noexec\3\4/" /etc/fstab

# Restrict Core Dumps
egrep -q "^(\s*)\*\s+hard\s+core\s+\S+(\s*#.*)?\s*$" /etc/security/limits.conf && sed -ri "s/^(\s*)\*\s+hard\s+core\s+\S+(\s*#.*)?\s*$/\1* hard core 0\2/" /etc/security/limits.conf || echo "* hard core 0" >> /etc/security/limits.conf
egrep -q "^(\s*)fs.suid_dumpable\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)fs.suid_dumpable\s*=\s*\S+(\s*#.*)?\s*$/\1fs.suid_dumpable = 0\2/" /etc/sysctl.conf || echo "fs.suid_dumpable = 0" >> /etc/sysctl.conf

# Enable Randomized Virtual Memory Region Placement
egrep -q "^(\s*)kernel.randomize_va_space\s*=\s*\S+(\s*#.*)?\s*$" /etc/sysctl.conf && sed -ri "s/^(\s*)kernel.randomize_va_space\s*=\s*\S+(\s*#.*)?\s*$/\1kernel.randomize_va_space = 2\2/" /etc/sysctl.conf || echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf

# Disable Prelink
dpkg -s prelink && apt-get -y purge prelink

# Disable Automounting
update-rc.d autofs disable

# Set Permissions on bootloader config
chmod g-r-w-x,o-r-w-x /boot/grub/grub.cfg

echo 'exit 0' > /etc/rc.local

chmod a-w /etc/sysctl.conf
rm -rf /usr/games/ 
rm -rf /usr/local/games 

echo "ALL: LOCAL, 127.0.0.1" >> /etc/hosts.allow
echo "ALL: PARANOID" > /etc/hosts.deny

sed -i 's/PATH=.*/PATH=\"\/usr\/local\/bin:\/usr\/bin:\/bin"/' /etc/environment
cp ./resources/initpath.sh /etc/profile.d/initpath.sh 

chown root:root /etc/profile.d/initpath.sh 
chmod 0644 /etc/profile.d/initpath.sh 

for users in games gnats irc list news uucp; do
    userdel -r "$users" 
done

if [ -f /etc/init.d/rc ]; then
    sed -i 's/umask 022/umask 027/g' /etc/init.d/rc
fi

if ! grep -q -i "umask" "/etc/profile" ; then
    echo "umask 027" >> /etc/profile
fi

if ! grep -q -i "umask" "/etc/bash.bashrc" ; then
    echo "umask 027" >> /etc/bash.bashrc
fi

if ! grep -q -i "TMOUT" "/etc/profile.d/*" ; then
    echo -e 'TMOUT=900\nreadonly TMOUT\nexport TMOUT' > '/etc/profile.d/autologout.sh'
    chmod +x /etc/profile.d/autologout.sh 
fi

local TEXT

for f in /etc/issue /etc/issue.net /etc/motd; do
    TEXT="\\nwarning : No scrubs from CyPat Discord... Not gonna name any names but uh *cough* lighthouse64 *cough*\\n"
    if [ -f $f ]; then
        echo -e "$TEXT" > $f
    fi
done

sed -i 's/ENABLED=.*/ENABLED=0/' /etc/default/motd-news
systemctl disable motd-news.timer 

if [ -f /etc/cups/cupsd.conf ]; then
    chmod 644 /etc/cups/cupsd.conf 
fi

##Sets default broswer
sed -i 's/x-scheme-handler\/http=.*/x-scheme-handler\/http=firefox.desktop/g' /home/$UserName/.local/share/applications/mimeapps.list

gsettings set org.gnome.desktop.session idle-delay 900 
gsettings set org.gnome.desktop.screensaver lock-delay 0 
gsettings set org.gnome.desktop.screensaver lock-enabled true 