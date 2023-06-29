#!/usr/bin/env bash 

set -euxo pipefail
IFS=$'\n\t'

hostname nixos-contabo \
&& curl https://raw.githubusercontent.com/elitak/nixos-infect/master/nixos-infect \
  | NIX_CHANNEL=nixos-23.05 NO_REBOOT=true bash -x \
&& { cat > /etc/nixos/flake.nix << 'EOF'
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
  };

  outputs = inputs:
    {
      nixosConfigurations.contabo-nixos = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ({ pkgs, ... }: {
            nix = {
              registry.nixpkgs.flake = inputs.nixpkgs;
              settings.experimental-features = [ "nix-command" "flakes" ];
              package = pkgs.nixFlakes;
            };
            system.stateVersion = "23.05";
          })
        ];
      };
    };
}
EOF
} \
&& /root/.nix-profile/bin/nix build \
  --extra-experimental-features "nix-command flakes" \
  /etc/nixos/#nixosConfigurations.contabo-nixos.config.system.build.toplevel
result/activate
result/bin/switch-to-configuration switch
rm -rf result
reboot
