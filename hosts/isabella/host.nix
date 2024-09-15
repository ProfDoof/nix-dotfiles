hostname:
inputs @ { nix-darwin, ... }:
{
  inherit hostname;
  system = "x86_64-darwin";
  configurationsKey = "darwinConfigurations";
  mkSystem = nix-darwin.lib.darwinSystem;
  modules = (import ../../common/darwin.nix inputs).modules ++ [
    ./configuration.nix
  ];
}
