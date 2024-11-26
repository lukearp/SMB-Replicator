#!/bin/sh
shares=$(echo "$SOURCEDESTINATIONSHARES" | jq -r '.[]')
echo $shares
count=1
for sync in $shares; do
    mkdir "/source$count"
    mkdir "/dest$count"
    $((count++))
done

if [ $Azure != "true" ]; then
    touch /root/.source-smb-credentials
    echo "user=$SOURCEUSERNAME" > /root/.source-smb-credentials
    sed -i "$ a pass=$SOURCEPASS" /root/.source-smb-credentials
    sed -i "$ a dom=$SOURCEDOMAIN" /root/.source-smb-credentials
    touch /root/.dest-smb-credentials
    echo "user=$DESTUSERNAME" > /root/.dest-smb-credentials
    sed -i "$ a pass=$DESTPASS" /root/.dest-smb-credentials
    sed -i "$ a dom=$DESTDOMAIN" /root/.dest-smb-credentials
    count=1
    for share in $shares; do        
        SOURCESHARE=$(echo "$share" | cut -d',' -f1)
        DESTSHARE=$(echo "$share" | cut -d',' -f2)
        sed -i "$ a //$SOURCESERVER/$SOURCESHARE /source$count cifs credentials=/root/.source-smb-credentials,iocharset=utf8,noperm 0 0" /etc/fstab   
        sed -i "$ a //$DESTSERVER/$DESTSHARE /dest$count cifs credentials=/root/.dest-smb-credentials,iocharset=utf8,noperm 0 0" /etc/fstab
        $((count++))
    done
    mount -a
fi 

while true; do
    count=1
    for sync in $shares; do
        echo "Copying /source$count/ to /dest$count/"
        rsync -av --delete /source$count/ /dest$count/
        $((count++))
    done
    sleep 60
done