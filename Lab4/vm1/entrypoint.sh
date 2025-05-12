#!/bin/bash
set -e

mkdir -p /srv/ftp/pub
mkdir -p /srv/ftp/incoming

chown ftp:ftp /srv/ftp/*
chmod 555 /srv/ftp/pub
chmod 773 /srv/ftp/incoming

mkuser () {
    local name="$1" pass="pass" mode="$2" homedir="/home/$name"

    adduser --disabled-password --gecos "" "$name"
    echo "$name:$pass" | chpasswd

    if [[ "$mode" == "ro" ]]; then
        chown root:root "$homedir"
        chmod 555       "$homedir"
    else
        chown "$name:$name" "$homedir"
        chmod 755           "$homedir"
    fi
}

mkuser mercury  ro
mkuser venus    ro
mkuser earth    rw
mkuser saturn   ro
mkuser jupiter  rw

mkdir -p /etc/vsftpd
printf "venus\njupiter\n" > /etc/vsftpd/chroot_list
install -d -o root -g root -m 755 /var/run/vsftpd/empty

exec "$@"

