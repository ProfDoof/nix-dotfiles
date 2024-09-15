{
  description = "My nix dotfiles for all systems";
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
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      fenix,
      ...
    }@inputs:
    (nixpkgs.lib.zipAttrsWith (name: vals: builtins.listToAttrs vals) (
      nixpkgs.lib.mapAttrsToList
        (
          hostDir: _:
          let
            host = import ./hosts/${hostDir}/host.nix "${hostDir}" inputs;
          in
          {
            "${host.configurationsKey}" = {
              name = "${hostDir}";
              value = (
                host.mkSystem {
                  system = host.system;
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
                    {
                      home-manager.useGlobalPkgs = true;
                      home-manager.useUserPackages = true;
                      home-manager.users.john = import ./users/john/home.nix;
                    }
                    (
                      { pkgs, config, ... }:
                      {
                        config.nixpkgs.overlays = [
                          fenix.overlays.default
                        ];
                      }
                    )
                  ] ++ host.modules;
                }
              );
            };
          }
        )
        (
          nixpkgs.lib.filterAttrs (
            host: type: type == "directory" && builtins.pathExists ./hosts/${host}/host.nix
          ) (builtins.readDir ./hosts)
        )
    ))
    // {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      formatter.x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.nixfmt-rfc-style;
    };

}
