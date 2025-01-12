{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.zsh;
  programs.appimage.binfmt = true;
}
