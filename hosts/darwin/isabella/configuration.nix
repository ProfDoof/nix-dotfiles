{ pkgs, ... }:
{
  imports = [
    ../../host.nix
  ];
  environment.systemPackages = with pkgs; [
    docker
  ];

  programs.zsh.enable = true;
  programs.fish.enable = true;
}
