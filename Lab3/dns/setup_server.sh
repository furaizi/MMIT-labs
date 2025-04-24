#!/bin/bash
set -e

named-checkconf
named-checkzone planet.edu /etc/bind/db.planet.edu
named-checkzone zone02.org /etc/bind/db.zone02.org
named-checkzone 11.168.192.in-addr.arpa /etc/bind/db.192.168.11
named -u bind -g