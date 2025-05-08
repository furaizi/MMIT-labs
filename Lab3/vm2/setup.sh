#!/bin/bash
set -e

# Set up DNS
chown -R bind:bind /var/cache/bind
named -u bind -g

# Prepare a TLS certificate
openssl genrsa -out mail.zone02.org.key 4096
openssl req  -new -key mail.zone02.org.key -out mail.zone02.org.csr \
  -subj "/C=UA/ST=Ukraine/L=Kyiv/O=KPI/OU=OT/CN=mail.zone02.org"

echo "[v3_req]
subjectAltName = DNS:mail.zone02.org,DNS:zone02.org" > san_vm2.cnf

openssl ca -config $CA_DIR/openssl.cnf \
  -in  mail.zone02.org.csr \
  -out mail.zone02.org.crt \
  -extfile san_vm2.cnf -extensions v3_req -days 825 -batch
