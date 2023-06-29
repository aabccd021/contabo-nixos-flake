# contabo-nixos-flake
Installing NixOS on contabo with flakes

## Scripts

Install on server with IP
```bash
curl -s https://raw.githubusercontent.com/aabccd021/contabo-nixos-flake/main/client-install.sh | bash -s <ip>
```

Switch Config of server with IP
```bash
curl -s https://raw.githubusercontent.com/aabccd021/contabo-nixos-flake/main/client-switch.sh | bash -s <ip>
```

Install from server shell
```bash
curl -s https://raw.githubusercontent.com/aabccd021/contabo-nixos-flake/main/server-install.sh | bash
```

## Tips
Copy configs
```bash
scp -r "root@$ip":/etc/nixos .
```
