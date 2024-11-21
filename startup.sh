#!/bin/sh

touch /root/.source-smb-credentials
echo "user=$SOURCEUSERNAME" > /root/.source-smb-credentials
sed -i "$ a pass=$SOURCEPASS" /root/.source-smb-credentials
sed -i "$ a dom=$SOURCEDOMAIN" /root/.source-smb-credentials
mkdir /source
sed -i "$ a //$SOURCESERVER/$SOURCESHARE /source cifs uid=1000,gid=1000,credentials=/root/.source-smb-credentials,iocharset=utf8,noperm 0 0" /etc/fstab

touch /root/.dest-smb-credentials
echo "user=$DESTUSERNAME" > /root/.dest-smb-credentials
sed -i "$ a pass=$DESTPASS" /root/.dest-smb-credentials
sed -i "$ a dom=$DESTDOMAIN" /root/.dest-smb-credentials
mkdir /dest
sed -i "$ a //$DESTSERVER/$DESTSHARE /dest cifs uid=1000,gid=1000,credentials=/root/.source-smb-credentials,iocharset=utf8,noperm 0 0" /etc/fstab

mount -a

while true; do
    rsync -av --delete /source/ /dest/
    sleep 60
done