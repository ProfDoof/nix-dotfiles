inputs: rec {
  system = import ./system.nix inputs;
  common = import ./common.nix inputs;
  modules = {
    mutableFiles = import ./modules/mutable-files.nix;
  };
  # private = import ./private.nix common;
}
