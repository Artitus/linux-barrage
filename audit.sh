#!/bin/bash

apt install -y auditd -y
systemctl enable --now auditd

# Keep All Auditing Information
egrep -q "^(\s*)max_log_file_action\s*=\s*\S+(\s*#.*)?\s*$" /etc/audit/auditd.conf && sed -ri "s/^(\s*)max_log_file_action\s*=\s*\S+(\s*#.*)?\s*$/\1max_log_file_action = keep_logs\2/" /etc/audit/auditd.conf || echo "max_log_file_action = keep_logs" >> /etc/audit/auditd.conf

sed -i 's/^action_mail_acct =.*/action_mail_acct = root/' "/etc/audit/auditd.conf"
sed -i 's/^space_left_action =.*/space_left_action = email/' "/etc/audit/auditd.conf"

# Enable Auditing for Processes That Start Prior to auditd
egrep -q "^(\s*)GRUB_CMDLINE_LINUX\s*=\s*\"([^\"]+)?\"(\s*#.*)?\s*$" /etc/default/grub && sed -ri '/^(\s*)GRUB_CMDLINE_LINUX\s*=\s*\"([^\"]*)?\"(\s*#.*)?\s*$/ {/^(\s*)GRUB_CMDLINE_LINUX\s*=\s*\"([^\"]+\s+)?audit=\S+(\s+[^\"]+)?\"(\s*#.*)?\s*$/! s/^(\s*GRUB_CMDLINE_LINUX\s*=\s*\"([^\"]+)?)(\"(\s*#.*)?\s*)$/\1 audit=1\3/ }' /etc/default/grub && sed -ri "s/^((\s*)GRUB_CMDLINE_LINUX\s*=\s*\"([^\"]+\s+)?)audit=\S+((\s+[^\"]+)?\"(\s*#.*)?\s*)$/\1audit=1\4/" /etc/default/grub || echo "GRUB_CMDLINE_LINUX=\"audit=1\"" >> /etc/default/grub
update-grub

# Record Events That Modify Date and Time Information
uname -p | grep -q 'x86_64' && egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b64\s+-S\s+adjtimex\s+-S\s+settimeofday\s+-k\s+time-change\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change" >> /etc/audit/audit.rules
egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b32\s+-S\s+adjtimex\s+-S\s+settimeofday\s+-S\s+stime\s+-k\s+time-change\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change" >> /etc/audit/audit.rules
uname -p | grep -q 'x86_64' && egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b64\s+-S\s+clock_settime\s+-k\s+time-change\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b64 -S clock_settime -k time-change" >> /etc/audit/audit.rules
egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b32\s+-S\s+clock_settime\s+-k\s+time-change\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b32 -S clock_settime -k time-change" >> /etc/audit/audit.rules
egrep -q "^\s*-w\s+/etc/localtime\s+-p\s+wa\s+-k\s+time-change\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /etc/localtime -p wa -k time-change" >> /etc/audit/audit.rules

# Record Events That Modify User/Group Information
egrep -q "^\s*-w\s+/etc/group\s+-p\s+wa\s+-k\s+identity\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /etc/group -p wa -k identity" >> /etc/audit/audit.rules
egrep -q "^\s*-w\s+/etc/passwd\s+-p\s+wa\s+-k\s+identity\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /etc/passwd -p wa -k identity" >> /etc/audit/audit.rules
egrep -q "^\s*-w\s+/etc/gshadow\s+-p\s+wa\s+-k\s+identity\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /etc/gshadow -p wa -k identity" >> /etc/audit/audit.rules
egrep -q "^\s*-w\s+/etc/shadow\s+-p\s+wa\s+-k\s+identity\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /etc/shadow -p wa -k identity" >> /etc/audit/audit.rules
egrep -q "^\s*-w\s+/etc/security/opasswd\s+-p\s+wa\s+-k\s+identity\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /etc/security/opasswd -p wa -k identity" >> /etc/audit/audit.rules

# Record Events That Modify the System's Network Environment
uname -p | grep -q 'x86_64' && egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b64\s+-S\s+sethostname\s+-S\s+setdomainname\s+-k\s+system-locale\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale" >> /etc/audit/audit.rules
egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b32\s+-S\s+sethostname\s+-S\s+setdomainname\s+-k\s+system-locale\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale" >> /etc/audit/audit.rules
egrep -q "^\s*-w\s+/etc/issue\s+-p\s+wa\s+-k\s+system-locale\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /etc/issue -p wa -k system-locale" >> /etc/audit/audit.rules
egrep -q "^\s*-w\s+/etc/issue.net\s+-p\s+wa\s+-k\s+system-locale\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /etc/issue.net -p wa -k system-locale" >> /etc/audit/audit.rules
egrep -q "^\s*-w\s+/etc/hosts\s+-p\s+wa\s+-k\s+system-locale\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /etc/hosts -p wa -k system-locale" >> /etc/audit/audit.rules
egrep -q "^\s*-w\s+/etc/sysconfig/network\s+-p\s+wa\s+-k\s+system-locale\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /etc/sysconfig/network -p wa -k system-locale" >> /etc/audit/audit.rules

# Record Events That Modify the System's Mandatory Access Controls
egrep -q "^\s*-w\s+/etc/selinux/\s+-p\s+wa\s+-k\s+MAC-policy\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /etc/selinux/ -p wa -k MAC-policy" >> /etc/audit/audit.rules

# Collect Login and Logout Events
egrep -q "^\s*-w\s+/var/log/faillog\s+-p\s+wa\s+-k\s+logins\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /var/log/faillog -p wa -k logins" >> /etc/audit/audit.rules
egrep -q "^\s*-w\s+/var/log/lastlog\s+-p\s+wa\s+-k\s+logins\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /var/log/lastlog -p wa -k logins" >> /etc/audit/audit.rules
egrep -q "^\s*-w\s+/var/log/tallylog\s+-p\s+wa\s+-k\s+logins\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /var/log/tallylog -p wa -k logins" >> /etc/audit/audit.rules

# Collect Session Initiation Information
egrep -q "^\s*-w\s+/var/run/utmp\s+-p\s+wa\s+-k\s+session\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /var/run/utmp -p wa -k session" >> /etc/audit/audit.rules
egrep -q "^\s*-w\s+/var/log/wtmp\s+-p\s+wa\s+-k\s+session\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /var/log/wtmp -p wa -k session" >> /etc/audit/audit.rules
egrep -q "^\s*-w\s+/var/log/btmp\s+-p\s+wa\s+-k\s+session\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /var/log/btmp -p wa -k session" >> /etc/audit/audit.rules

# Collect Discretionary Access Control Permission Modification Events
uname -p | grep -q 'x86_64' && egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b64\s+-S\s+chmod\s+-S\s+fchmod\s+-S\s+fchmodat\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+perm_mod\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod" >> /etc/audit/audit.rules
egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b32\s+-S\s+chmod\s+-S\s+fchmod\s+-S\s+fchmodat\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+perm_mod\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod" >> /etc/audit/audit.rules
uname -p | grep -q 'x86_64' && egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b64\s+-S\s+chown\s+-S\s+fchown\s+-S\s+fchownat\s+-S\s+lchown\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+perm_mod\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod" >> /etc/audit/audit.rules
egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b32\s+-S\s+chown\s+-S\s+fchown\s+-S\s+fchownat\s+-S\s+lchown\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+perm_mod\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod" >> /etc/audit/audit.rules
uname -p | grep -q 'x86_64' && egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b64\s+-S\s+setxattr\s+-S\s+lsetxattr\s+-S\s+fsetxattr\s+-S\s+removexattr\s+-S\s+lremovexattr\s+-S\s+fremovexattr\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+perm_mod\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod" >> /etc/audit/audit.rules
egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b32\s+-S\s+setxattr\s+-S\s+lsetxattr\s+-S\s+fsetxattr\s+-S\s+removexattr\s+-S\s+lremovexattr\s+-S\s+fremovexattr\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+perm_mod\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod" >> /etc/audit/audit.rules

# Collect Unsuccessful Unauthorized Access Attempts to Files
uname -p | grep -q 'x86_64' && egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b64\s+-S\s+creat\s+-S\s+open\s+-S\s+openat\s+-S\s+truncate\s+-S\s+ftruncate\s+-F\s+exit=-EACCES\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+access\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access" >> /etc/audit/audit.rules
egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b32\s+-S\s+creat\s+-S\s+open\s+-S\s+openat\s+-S\s+truncate\s+-S\s+ftruncate\s+-F\s+exit=-EACCES\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+access\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access" >> /etc/audit/audit.rules
uname -p | grep -q 'x86_64' && egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b64\s+-S\s+creat\s+-S\s+open\s+-S\s+openat\s+-S\s+truncate\s+-S\s+ftruncate\s+-F\s+exit=-EPERM\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+access\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access" >> /etc/audit/audit.rules
egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b32\s+-S\s+creat\s+-S\s+open\s+-S\s+openat\s+-S\s+truncate\s+-S\s+ftruncate\s+-F\s+exit=-EPERM\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+access\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access" >> /etc/audit/audit.rules

# Collect Use of Privileged Commands
for file in `find / -xdev \( -perm -4000 -o -perm -2000 \) -type f`; do egrep -q "^\s*-a\s+(always,exit|exit,always)\s+-F\s+path=$file\s+-F\s+perm=x\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+privileged\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F path=$file -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged" >> /etc/audit/audit.rules; done

# Collect Successful File System Mounts
uname -p | grep -q 'x86_64' && egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b64\s+-S\s+mount\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+mounts\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts" >> /etc/audit/audit.rules
egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b32\s+-S\s+mount\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+mounts\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts" >> /etc/audit/audit.rules

# Collect File Deletion Events by User
uname -p | grep -q 'x86_64' && egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b64\s+-S\s+unlink\s+-S\s+unlinkat\s+-S\s+rename\s+-S\s+renameat\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+delete\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete" >> /etc/audit/audit.rules
egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b32\s+-S\s+unlink\s+-S\s+unlinkat\s+-S\s+rename\s+-S\s+renameat\s+-F\s+auid>=1000\s+-F\s+auid!=4294967295\s+-k\s+delete\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete" >> /etc/audit/audit.rules

# Collect Changes to System Administration Scope (sudoers)
egrep -q "^\s*-w\s+/etc/sudoers\s+-p\s+wa\s+-k\s+scope\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /etc/sudoers -p wa -k scope" >> /etc/audit/audit.rules

# Collect System Administrator Actions (sudolog)
egrep -q "^\s*-w\s+/var/log/sudo.log\s+-p\s+wa\s+-k\s+actions\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /var/log/sudo.log -p wa -k actions" >> /etc/audit/audit.rules

# Collect Kernel Module Loading and Unloading
egrep -q "^\s*-w\s+/sbin/insmod\s+-p\s+x\s+-k\s+modules\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /sbin/insmod -p x -k modules" >> /etc/audit/audit.rules
egrep -q "^\s*-w\s+/sbin/rmmod\s+-p\s+x\s+-k\s+modules\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /sbin/rmmod -p x -k modules" >> /etc/audit/audit.rules
egrep -q "^\s*-w\s+/sbin/modprobe\s+-p\s+x\s+-k\s+modules\s*(#.*)?$" /etc/audit/audit.rules || echo "-w /sbin/modprobe -p x -k modules" >> /etc/audit/audit.rules
uname -p | grep -q 'x86_64' && egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b64\s+-S\s+init_module\s+-S\s+delete_module\s+-k\s+modules\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b64 -S init_module -S delete_module -k modules" >> /etc/audit/audit.rules
uname -p | grep -q 'x86_64' || (egrep -q "^\s*-a\s+always,exit\s+-F\s+arch=b32\s+-S\s+init_module\s+-S\s+delete_module\s+-k\s+modules\s*(#.*)?$" /etc/audit/audit.rules || echo "-a always,exit -F arch=b32 -S init_module -S delete_module -k modules" >> /etc/audit/audit.rules)

# Make the Audit Configuration Immutable
sed -r '/^\s*(#.*)?$/ d' /etc/audit/audit.rules | tail -n 1 | egrep -q "^\s*-e 2\s*(#.*)?$" || (sed '/^\s*-e 2\s*(#.*)?$/ d' /etc/audit/audit.rules && echo "-e 2" >> /etc/audit/audit.rules)

sed -i 's/^#Storage=.*/Storage=persistent/' "/etc/systemd/journald.conf"
sed -i 's/^#ForwardToSyslog=.*/ForwardToSyslog=yes/' "/etc/systemd/journald.conf"
sed -i 's/^#Compress=.*/Compress=yes/' "/etc/systemd/journald.conf"
systemctl restart systemd-journald
systemctl restart auditd