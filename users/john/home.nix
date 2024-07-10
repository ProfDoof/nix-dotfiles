{ config, pkgs, ... }:

{
  imports = [
    ./sway.nix
    ./hx.nix
  ];
  targets.genericLinux.enable = true;
  
  home.username = "john";
  home.homeDirectory = "/home/john";

  home.packages = with pkgs; [
    # Archival
    zip
    xz
    unzip
    p7zip
    
    # utils
    ripgrep
    jq
    yq-go
    eza
    fzf
    
    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # productivity
    hugo
    glow
    btop
    iotop
    iftop
    wineWowPackages.waylandFull
    winetricks

    # syscall monitory
    strace
    ltrace
    lsof

    # systools
    sysstat
    ethtool
    pciutils
    usbutils

    # LibreOffice
    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.th_TH

    # Work
    zoom-us
    slack
    openconnect
  ];


  programs.git = {
    enable = true;
    userName = "John Marsden";
    userEmail = "john@johnmarsden.dev";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.java.enable = true;

  programs.bash.enable = true;
  programs.fish.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -alh";
      update = "sudo nixos-rebuild switch --flake /home/john/.dotfiles/";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
      ];
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      shell = "${pkgs.zsh}/bin/zsh";
      font.size = 14;
    };
  };

  programs.firefox = {
    nativeMessagingHosts = [
      pkgs.gnome-browser-connector
      
    ];
    enable = true;
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
