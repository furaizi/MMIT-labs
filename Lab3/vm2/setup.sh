#!/bin/bash
set -e

# Set up DNS
chown -R bind:bind /var/cache/bind
named -u bind -g &

update-ca-certificates
# Initialize services
service postfix start
service dovecot start

# Create mail addresses
postmap /etc/postfix/vmailbox
for u in jupiter saturn; do
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