{ pkgs, ... }:
{
  imports = [
    ./ide/default.nix
  ];

  programs.java.enable = true;
}
