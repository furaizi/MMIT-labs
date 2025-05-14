#!/bin/bash
set -e

mkdir -p /srv/ftp/pub
mkdir -p /srv/ftp/incoming

chown ftp:ftp /srv/ftp/*
chmod 555 /srv/ftp/pub
chmod 777 /srv/ftp/incoming

# Create FTP users
for u in mercury venus earth saturn jupiter; do
    adduser --disabled-password --gecos "" $u
    echo "$u:pass" | chpasswd
done

# Set up readonly access
for u in mercury venus saturn; do
    chown root:root "/home/$u"
    chmod 555 "/home/$u"
done

# Set up read-write access
for u in earth jupiter; do
    chown "$u:$u" "/home/$u"
    chmod 755 "/home/$u"
done


mkdir -p /etc/vsftpd
printf "venus\njupiter\n" > /etc/vsftpd/chroot_list
install -d -o root -g root -m 755 /var/run/vsftpd/empty

exec "$@"

