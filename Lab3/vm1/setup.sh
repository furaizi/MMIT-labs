#!/bin/bash
set -e

# Set up DNS
named-checkconf
named-checkzone planet.edu /etc/bind/db.planet.edu
named-checkzone zone02.org /etc/bind/db.zone02.org
named-checkzone 11.168.192.in-addr.arpa /etc/bind/db.192.168.11
named -u bind -g

update-ca-certificates
service rsyslog start
service postfix start

# Set up Dovecot
sed -i 's/^#*\s*disable_plaintext_auth.*/disable_plaintext_auth = yes/' \
    /etc/dovecot/conf.d/10-auth.conf
sed -i 's/^#*\s*auth_mechanisms.*/auth_mechanisms = plain login/' \
    /etc/dovecot/conf.d/10-auth.conf
cat > /etc/dovecot/conf.d/10-ssl.conf <<EOF
ssl = required
ssl_cert = </etc/ssl/local/${HOSTNAME}.crt
ssl_key  = </etc/ssl/local/${HOSTNAME}.key
ssl_ca   = </etc/ssl/local/planet-ca.crt
ssl_min_protocol = TLSv1.2
EOF

service dovecot start