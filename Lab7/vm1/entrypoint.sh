#!/bin/bash
set -e

for u in mercury venus earth; do
    htpasswd -b -c /etc/nginx/.htpasswd "$u" "pass"
done

nginx -g 'daemon off;' &

exec "$@"