#!/usr/bin/env bash 

set -euxo pipefail
IFS=$'\n\t'

ip="$1"

ssh-keygen -R "$ip" \
&& ssh-copy-id "root@$ip" \
&& ssh "root@$ip" "curl -s https://raw.githubusercontent.com/aabccd021/contabo-nixos-flake/main/server-install.sh | bash"
