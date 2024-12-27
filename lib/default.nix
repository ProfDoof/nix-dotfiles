inputs:
rec {
  system = import ./system.nix inputs;
  common = import ./common.nix inputs;
  # private = import ./private.nix common;
}