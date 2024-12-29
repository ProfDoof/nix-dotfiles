{ pkgs, ... }:

{
  projectRootFile = "flake.nix";
  programs.nixfmt.enable = true;
  settings.verbose = 2;
  settings.formatter."talonfmt" = {
    command = "${pkgs.pipx}/bin/pipx";
    options = [
      "run"
      "talonfmt"
      "--in-place"
    ];
    includes = [ "*.talon" ];
  };
  settings.global.excludes = [
    ".direnv/"
    ".env"
    ".envrc"
    ".gitignore"
    "target/"
    ".vscode/"
  ];
}
