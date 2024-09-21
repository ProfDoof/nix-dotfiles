{ ... }:

{
  projectRootFile = "flake.nix";
  programs.nixfmt.enable = true;
  settings.global.excludes = [
    ".direnv/*"
    ".env"
    ".envrc"
    ".gitignore"
  ];
}
