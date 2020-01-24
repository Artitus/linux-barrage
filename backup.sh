cp -r --parents /etc/sudoers /backup/
cp -r --parents /var/log/ /backup/
cp -r --parents /etc/passwd /backup/
cp -r --parents /etc/group /backup/
cp -r --parents /etc/shadow /backup/
cp -r --parents /var/spool/mail /backup/

for h in `ls /home`
do
    cp -r --parents /home/$h /backup/
done