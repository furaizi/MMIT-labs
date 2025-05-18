#!/bin/bash
set -e

rpcbind -w
rpc.statd --no-notify
mkdir -p /mnt/nfs_public /mnt/nfs_private /mnt/nfs_incoming

exec "$@"