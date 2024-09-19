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
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    talon-nix = {
      url = "github:nix-community/talon-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixos-cosmic, home-manager, nixpkgs-wayland, fenix, nix-darwin, mac-app-util, ... }:
    let
      commonModules = [
        {
          nix.settings = {
            experimental-features = [ "nix-command" "flakes" ];
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
        ({ pkgs, config, ... }: {
          # Allow unfree packages
          config.nixpkgs = {
            config.allowUnfree = true;
            overlays = [
              fenix.overlays.default
            ];
          };
        })
      ];
      darwinModules = commonModules ++ [
        mac-app-util.darwinModules.default
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.sharedModules = [ mac-app-util.homeManagerModules.default ];
          home-manager.users.john = (import ./users/john/darwin.nix {
            homeDirectory = "/Users/john";
          });
          users.users.john.home = "/Users/john";
        }
      ];
      nixOsModules = commonModules ++ [
        nixos-cosmic.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.john = (import ./users/john/home.nix {
            homeDirectory = "/home/john";
          });
        }
        ({ pkgs, config, ... }: {
          config.nixpkgs.overlays = [
            nixpkgs-wayland.overlay
          ];
        })
      ];
      getHosts = hostType: (
        nixpkgs.lib.filterAttrs
          (host: type: type == "directory" && builtins.pathExists (./hosts/${hostType}/${host}/configuration.nix))
          (builtins.readDir ./hosts/${hostType})
      );
    in
    {
      nixosConfigurations =
        nixpkgs.lib.mapAttrs
          (host: _: nixpkgs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = nixOsModules ++ [
              ./hosts/nixos/${host}/configuration.nix
            ];
          })
          (getHosts "nixos");
      darwinConfigurations =
        nixpkgs.lib.mapAttrs
          (host: _: nix-darwin.lib.darwinSystem {
            system = "x86_64-darwin";
            modules = darwinModules ++ [
              ./hosts/darwin/${host}/configuration.nix
            ];
          })
          (getHosts "darwin");
    };
}
