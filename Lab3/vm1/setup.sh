#!/bin/bash
set -e

# Set up DNS
named-checkconf
named-checkzone planet.edu /etc/bind/db.planet.edu
named-checkzone zone02.org /etc/bind/db.zone02.org
named-checkzone 11.168.192.in-addr.arpa /etc/bind/db.192.168.11
named -u bind -g &

update-ca-certificates
# Initialize services
service postfix start
service dovecot start

# Create mail addresses
postmap /etc/postfix/vmailbox
for u in mercury venus earth; do
  for f in cur new tmp; do
    mkdir -p /var/mail/vhosts/planet.edu/$u/Maildir/$f
  done
done
groupadd --system --gid 5000 vmail
useradd  --system --uid 5000 --gid vmail \
         --home-dir /var/mail/vhosts --shell /usr/sbin/nologin vmail
chown -R vmail:vmail /var/mail/vhosts
chmod -R 700 /var/mail/vhosts

exec "$@"