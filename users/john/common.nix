{ pkgs, ... }:
{
  imports = [
    ./dev
    ./ergo
    ./ncsu
  ];

  home.packages = with pkgs; [

    # Teaching Work
    zoom-us
    slack
    openconnect

    # Fun and games
    spotify
    # TODO: Check if this is still marked insecure
    element-desktop
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = "${pkgs.zsh}/bin/zsh";
      font.size = 14;
    };
  };

  programs.bash.enable = true;
  programs.zsh.enable = true;

  programs.firefox.enable = true;

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
