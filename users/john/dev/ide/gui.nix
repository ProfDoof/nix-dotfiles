{ pkgs, inputs, system, ... }:
let
  inherit (inputs) fenix nix-vscode-extensions;
  vscode-marketplace = (nix-vscode-extensions.extensions.${system}.forVSCodeVersion pkgs.vscode.version).vscode-marketplace;
in
{
  programs = {
    vscode = {
      enable = true;
      mutableExtensionsDir = false;
      extensions =
        [
          fenix.rust-analyzer-vscode-extension
        ]
        ++ (with vscode-marketplace; [
          ms-python.python
          redhat.java
          mkhl.direnv
          jnoortheen.nix-ide
          tomoki1207.pdf
          sandcastle.vscode-open
          arrterian.nix-env-selector
          george-alisson.html-preview-vscode
        ]);
    };
  };
}
