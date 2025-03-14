{ config, pkgs, ... }:
{
  imports = [
    ./common.nix
    ./de
    ./hobby
  ];
  targets.genericLinux.enable = true;

  home.username = "john";
  home.homeDirectory = "/home/john";

  home.packages = with pkgs; [
    qnotero

    iotop
    strace

    # syscall monitory
    ltrace
    lsof

    # systools
    sysstat
    ethtool
    pciutils
    usbutils

    # Research Work
    zotero_7

    # LibreOffice (not supported on mac weirdly enough?)
    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.th_TH
    bitwarden-desktop
  ];

  programs.zsh = {
    shellAliases.update = "sudo nixos-rebuild switch --flake /home/john/.dotfiles/";
    history.path = "${config.xdg.dataHome}/zsh/history";
    envExtra = "export XDG_DATA_HOME=\"/home/john/.local/share\"";
  };

  services.xembed-sni-proxy = {
    enable = true;
    package = pkgs.kdePackages.plasma-workspace;
    
  };
}
