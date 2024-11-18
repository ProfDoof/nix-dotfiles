{ pkgs, ... }:
{
  imports = [
    ./ide/default.nix
    ./git
  ];

  programs.java.enable = true;
}
