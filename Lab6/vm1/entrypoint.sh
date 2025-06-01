#!/bin/bash

set -e

for u in mercury venus saturn guest; do
    # Linux users
    adduser --disabled-password --gecos "" "$u" || true
    echo "$u:pass" | chpasswd

    # Samba users
    if [ "$u" = "guest" ]; then
        smbpasswd -a -n "$u" || true
    else
        printf "pass\npass\n" | smbpasswd -a -s "$u" || true
    fi
    smbpasswd -e "$u" || true

    # Create home directories
    mkdir -p /srv/samba/home/"$u"
done

for d in hidden public incoming; do
    mkdir -p /srv/samba/"$d"
done;

chown -R root:root /srv/samba
chmod -R 0777 /srv/samba

nmbd -D
smbd -D

exec "$@"