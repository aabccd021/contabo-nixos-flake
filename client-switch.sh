#!/usr/bin/env bash 

set -euxo pipefail
IFS=$'\n\t'

ip="$1"

ssh "root@$ip" "rm -rf /etc/nixos" \
&& rsync --delete --archive --verbose --recursive --partial --progress ./nixos "root@$ip":/etc \
&& ssh "root@$ip" "cd /etc/nixos && nixos-rebuild switch --flake .#contabo-nixos"
