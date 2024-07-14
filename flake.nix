{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
    };
  };

  outputs = { self, nixpkgs, nixos-cosmic, home-manager, nixpkgs-wayland }:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      modules = [
        nixos-cosmic.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.john = import ./users/john/home.nix;
        }
        ({ pkgs, config, ... }: {
          config.nixpkgs.overlays = [ nixpkgs-wayland.overlay ];
        })
      ];
      hosts = (
        lib.filterAttrs
          (host: type: type == "directory" && builtins.pathExists (./hosts + "/${host}/configuration.nix"))
          (builtins.readDir ./hosts)
      );
    in
    {
      nixosConfigurations =
        lib.mapAttrs
          (host: _: lib.nixosSystem {
            inherit system;
            modules = modules ++ [
              ./hosts/${host}/configuration.nix
            ];
          })
          hosts;
    };
}
