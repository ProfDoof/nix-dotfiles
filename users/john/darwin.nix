{ homeDirectory }:
{ config, pkgs, ... }:

{
  imports = [
    ./hx.nix
  ];

  home.username = "john";
  home.homeDirectory = homeDirectory;

  home.packages = with pkgs; [
    # # Archival
    # zip
    # xz
    # unzip
    # p7zip

    # # utils
    # ripgrep
    # jq
    # yq-go
    # eza
    # fzf

    # # misc
    # cowsay
    # file
    # which
    # tree
    # gnused
    # gnutar
    # gawk
    # zstd
    # gnupg

    # # productivity
    # hugo
    # glow
    # btop
    # iotop
    # iftop
    # wineWowPackages.waylandFull
    # winetricks
    # bottles

    # # syscall monitory
    # strace
    # ltrace
    # lsof

    # # systools
    # sysstat
    # ethtool
    # pciutils
    # usbutils

    # # LibreOffice
    # libreoffice-qt
    # hunspell
    # hunspellDicts.uk_UA
    # hunspellDicts.th_TH

    # # Teaching Work
    # zoom-us
    # slack
    # openconnect

    # # Research Work
    # zotero_7
    # qnotero

    # # Programming
    # (fenix.complete.withComponents [
    #   "cargo"
    #   "clippy"
    #   "rust-src"
    #   "rustc"
    #   "rustfmt"
    # ])
    # rust-analyzer-nightly
    # jdt-language-server
    # lldb
    # bash-language-server
    # omnisharp-roslyn
    # netcoredbg
    # taplo

    # # Fun and games
    # spotify
    # # cinny-desktop
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
    #   ms-python.python
    #   rust-lang.rust-analyzer-nightly
    #   ms-toolsai.jupyter
      # ms-vscode.cpptools
    #   redhat.java
    ];
  };
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
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -alh";
      update = "darwin-rebuild switch --flake /home/john/.dotfiles/";
    };
    history = {
      size = 10000;
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

#   programs.firefox = {
#     nativeMessagingHosts = [
#       pkgs.gnome-browser-connector

#     ];
#     enable = true;
#   };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
