{ pkgs, ... }:
{
  imports = [ ./hx.nix ];
  home.packages = with pkgs; [

    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly
    jdt-language-server
    lldb
    bash-language-server
    omnisharp-roslyn
    netcoredbg
    taplo
    nil
  ];
  programs = {

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    zsh.enable = true;

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        rust-lang.rust-analyzer-nightly
        redhat.java
        mkhl.direnv
        jnoortheen.nix-ide
      ];
    };

    git = {
      enable = true;
      userName = "John Marsden";
      userEmail = "john@johnmarsden.dev";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };
  };
}
