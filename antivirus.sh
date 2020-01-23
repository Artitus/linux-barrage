# Install nullmailer to avoid postfix for rkhunter
sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install nullmailer
apt install -y clamav clamav-daemon rkhunter chkrootkit unhide

cat ./data/antivirus/clam* > ./data/antivirus/clam.tar.xz
tar xf ./data/antivirus/clam.tar.xz -C ./data/antivirus/
cp -f ./data/antivirus/*.cvd /var/lib/clamav/
chown clamav:clamav /var/lib/clamav/*.cvd
chmod 644 /var/lib/clamav/*.cvd

rkhunter --update
rkhunter --popupd

# Run
clamscan --log=./log/clamscan
rkhunter --check
chkrootkit
unhide -f brute proc procall procfs quick reverse sys