{ pkgs, ... }:
{
  # services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  nixpkgs.hostPlatform = "x86_64-darwin";
  system.stateVersion = 5;
}
