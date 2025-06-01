#!/bin/bash

set -e

for u in mercury venus saturn guest; do
    adduser --disabled-password --gecos "" "$u"
    echo "$u:pass" | chpasswd
    if [ "$u" = "guest" ]; then
        smbpasswd -a -s "$u"
    else
        printf "pass\npass\n" | smbpasswd -a -s "$u"
    fi
    smbpasswd -e "$u"
done

for d in hidden home public incoming; do
    mkdir /srv/samba/"$d"
done;

chown -R root:root /srv/samba
chmod -R 0770 /srv/samba/hidden
chmod -R 0700 /srv/samba/home
chmod -R 0555 /srv/samba/public
chmod -R 0777 /srv/samba/incoming

nmbd -D
smbd -D

exec "$@"