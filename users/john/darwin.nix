{ pkgs, ... }:
{
  imports = [
    ./common.nix
  ];

  home.packages = with pkgs; [
    unnaturalscrollwheels
  ];

  home.username = "john";
  home.homeDirectory = "/Users/john";

  programs.zsh.shellAliases.update = "darwin-rebuild switch --flake /Users/john/.dotfiles/";
}
