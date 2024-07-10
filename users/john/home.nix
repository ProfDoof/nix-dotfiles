{ config, pkgs, ... }:

{
  imports = [
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

    # Dev
    dotnet-sdk
    fsautocomplete
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
      update = "sudo nixos-rebuild switch --flake ~/.dotfiles/";
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

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      fonts = {
        size = 14.0;
      };
      gaps = {
        inner = 5;
        outer = 5;
      };
    };
    extraConfig = ''
      # Brightness Controls
      bindsym XF86MonBrightnessDown exec light -U 10
      bindsym XF86MonBrightnessUp exec light -A 10

      # Audio Controls
      bindsym XF86AudioRaiseVolume exec 'wpctl set-volume -l 1.0 @DEFAULT_SINK@ +1.0%'
      bindsym XF86AudioLowerVolume exec 'wpctl set-volume -l 1.0 @DEFAULT_SINK@ -1.0%'
      bindsym XF86AudioMute exec 'wpctl set-mute @DEFAULT_SINK@ toggle'
    '';
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
