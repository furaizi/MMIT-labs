#!/bin/bash
set -e

# Create NFS users
for u in mercury venus earth jupiter saturn; do
    adduser --disabled-password --gecos "" "$u"
    echo "$u:pass" | chpasswd
done

mkdir -p /nfs/public /nfs/private /nfs/incoming

# Set up access to /nfs/public
chown root:root /nfs/public
chmod 755 /nfs/public

# Set up access to /nfs/private
chown mercury:mercury /nfs/private
chmod 700 /nfs/private

# Set up access to /nfs/incoming
chown venus:venus /nfs/incoming
chmod 770 /nfs/incoming
setfacl -m u:venus:rwx,u:earth:rwx,u:jupiter:rx,u:saturn:0 /nfs/incoming

rpcbind -w
mount -t nfsd nfsd /proc/fs/nfsd || true

exportfs -arv
rpc.nfsd --debug --syslog 8
rpc.mountd -N 4 -V 3

exec "$@"