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
    mkdir -p /srv/samba/"$d"
done;

chown -R root:root /srv/samba
chmod -R 0777 /srv/samba

nmbd -D
smbd -D

exec "$@"