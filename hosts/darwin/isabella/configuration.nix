{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [

  ];

  programs.zsh.enable = true;
  programs.fish.enable = true;
}
