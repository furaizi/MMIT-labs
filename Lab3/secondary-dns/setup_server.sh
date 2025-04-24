#!/bin/bash
set -e

chown -R bind:bind /var/cache/bind
named -u bind -g