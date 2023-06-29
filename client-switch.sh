#!/usr/bin/env bash 

set -euxo pipefail
IFS=$'\n\t'

ip="$1"

ssh "root@$ip" "rm -rf /etc/nixos" \
&& scp -r ./nixos "root@$ip":/etc/nixos \
&& ssh "root@$ip" "cd /etc/nixos && nixos-rebuild switch --verbose --flake .#contabo-nixos"
