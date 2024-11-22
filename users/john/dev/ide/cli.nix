{ pkgs, ... }:
{
  imports = [
    ./hx/default.nix
  ];

  home.packages = with pkgs; [
    # Archival
    zip
    xz
    unzip
    p7zip
    rar

    # utils
    ripgrep
    jq
    yq-go
    eza
    fzf
    fd
    dua
    gh
    git-lfs

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
    btop
    iftop
  ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases.ll = "ls -alh";
      history.size = 10000;
      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; }
        ];
      };
    };
  };
}
