{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-cosmic, home-manager, nixpkgs-wayland, fenix }:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      modules = [
        {
          nix.settings = {
            extra-substituters = [
              "https://cache.nixos.org/"
              "https://cosmic.cachix.org/"
              "https://nixpkgs-wayland.cachix.org/"
              "https://nix-community.cachix.org/"
            ];
            trusted-public-keys = [
              "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
              "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
              "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
              "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            ];
          };
        }
        nixos-cosmic.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.john = import ./users/john/home.nix;
        }
        ({ pkgs, config, ... }: {
          config.nixpkgs.overlays = [
            nixpkgs-wayland.overlay
            fenix.overlays.default
          ];
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
