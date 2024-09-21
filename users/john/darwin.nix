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

  programs.bash.enable = true;
  programs.zsh.shellAliases.update = "darwin-rebuild switch --flake /home/john/.dotfiles/";
}
