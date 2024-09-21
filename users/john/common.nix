{ pkgs, ... }:
{
  imports = [
    ./dev/default.nix
  ];

  home.packages = with pkgs; [

    # Teaching Work
    zoom-us
    slack
    openconnect

    # Fun and games
    spotify
    # TODO: Check if this is still marked insecure
    # cinny-desktop
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      shell = "${pkgs.zsh}/bin/zsh";
      font.size = 14;
    };
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
