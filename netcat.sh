#!/bin/bash

a=0;
for i in $(netstat -ntlup | grep -e "netcat" -e "nc" -e "ncat"); do
	if [[ $(echo $i | grep -c -e "/") -ne 0  ]]; then
		badPID=$(ps -ef | pgrep $( echo $i  | cut -f2 -d'/'));
		realPath=$(ls -la /proc/$badPID/exe | cut -f2 -d'>' | cut -f2 -d' ');
		cp $realPath $a
        log netcat "$realPath $a"
		a=$((a+1));
		rm $realPath;
		kill $badPID;
	fi
done
apt-get purge netcat -y -qq 
apt-get purge netcat-openbsd -y -qq 
apt-get purge netcat-traditional -y -qq 
apt-get purge ncat -y -qq 
apt-get purge pnetcat -y -qq 
apt-get purge socat -y -qq 
apt-get purge sock -y -qq 
apt-get purge socket -y -qq 
apt-get purge sbd -y -qq 
rm /usr/bin/nc 