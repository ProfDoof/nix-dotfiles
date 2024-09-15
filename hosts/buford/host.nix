hostname:
inputs @ { nixpkgs, ... }:
{
  inherit hostname;
  system = "x86_64-linux";
  configurationsKey = "nixosConfigurations";
  mkSystem = nixpkgs.lib.nixosSystem;
  modules = (import ../../common/nixos.nix inputs).modules ++ [
    ./configuration.nix
  ];
}
