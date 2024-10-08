{ pkgs, ... }:
{
  programs = {
    vscode = {
      enable = true;
      mutableExtensionsDir = false;
      extensions =
        (with pkgs.vscode-extensions; [
          rust-lang.rust-analyzer-nightly
        ])
        ++ (with (pkgs.forVSCodeVersion pkgs.vscode.version).vscode-marketplace; [
          ms-python.python
          redhat.java
          mkhl.direnv
          jnoortheen.nix-ide
        ]);
    };
  };
}
