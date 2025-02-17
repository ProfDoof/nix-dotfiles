{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nil
    python3Full
  ];
  programs = {
    vscode = {
      enable = true;
      mutableExtensionsDir = true;
      extensions =
        (with pkgs.vscode-extensions; [
          rust-lang.rust-analyzer-nightly
          # ms-vscode.cpptools
        ])
        ++ (with (pkgs.forVSCodeVersion pkgs.vscode.version).vscode-marketplace; [
          ms-python.python
          redhat.java
          mkhl.direnv
          jnoortheen.nix-ide
          tomoki1207.pdf
          sandcastle.vscode-open
          arrterian.nix-env-selector
          george-alisson.html-preview-vscode
          sissel.shopify-liquid
          pokey.cursorless
          pokey.talon
          sleistner.vscode-fileutils
          pokey.command-server
          pokey.parse-tree
          astro-build.astro-vscode
          vadimcn.vscode-lldb
          marlinfirmware.auto-build
          platformio.platformio-ide
          paulschaaf.talon-filetree
        ])
        ++ (with (pkgs.forVSCodeVersion pkgs.vscode.version).vscode-marketplace-release; [
          github.copilot
          github.copilot-chat
        ]);
    };
  };
}
