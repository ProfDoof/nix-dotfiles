{ pkgs, ... }:
{
  programs = {
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
  };
}
