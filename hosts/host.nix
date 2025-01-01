{ pkgs, ... }:
{
  programs.talon.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
