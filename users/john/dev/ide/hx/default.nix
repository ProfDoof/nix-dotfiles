{ pkgs, ... }:

{
  imports = [
    ./void.nix
    ./languages.nix
    ./settings.nix
  ];

  programs.helix = {
    enable = true;
  };
}
