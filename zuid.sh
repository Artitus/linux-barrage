touch zuid_users.log
touch uid_users.log
cut -d: -f1,3 /etc/passwd | egrep ':0$' | cut -d: -f1 | grep -v root > zuid_users.log

if [ -s zuid_users.log ]
then
	while IFS='' read -r line || [[ -n "$line" ]]; do
		thing=1
		while true; do
			rand=$(( ( RANDOM % 999 ) + 1000))
			cut -d: -f1,3 /etc/passwd | egrep ":$rand$" | cut -d: -f1 > uid_users.log
			if ! [ -s uid_users.log ]
			then
				break
			fi
		done
		usermod -u $rand -g $rand -o $line 2>&1 > /dev/null
		touch /tmp/oldstring
		old=$(grep "$line" /etc/passwd)
		echo $old > /tmp/oldstring
		sed -i "s~0:0~$rand:$rand~" /tmp/oldstring
		new=$(cat /tmp/oldstring)
		sed -i "s~$old~$new~" /etc/passwd
	done < "zuid_users.log"
	update-passwd
	cut -d: -f1,3 /etc/passwd | egrep ':0$' | cut -d: -f1 | grep -v root > zuid_users.log

	if [ -s zuid_users.log ]
	then
		echo "WARNING: UID CHANGE UNSUCCESSFUL!"
	else
		echo "Successfully Changed Zero UIDs!"
	fi
fi