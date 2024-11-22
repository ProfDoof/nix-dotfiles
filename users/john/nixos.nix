{ config, pkgs, ... }:
{
  imports = [
    ./common.nix
    ./de/default.nix
    ./hobby/default.nix
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
  ];

  programs.zsh = {
    shellAliases.update = "sudo nixos-rebuild switch --flake /home/john/.dotfiles/";
    history.path = "${config.xdg.dataHome}/zsh/history";
    envExtra = "export XDG_DATA_HOME=\"/home/john/.local/share\"";
  };

  programs.firefox = {
    nativeMessagingHosts = [
      pkgs.gnome-browser-connector

    ];
    enable = true;
  };

  services.xembed-sni-proxy.enable = true;
}
