{
  description = "Contabo Flake NixOS configuration";

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
