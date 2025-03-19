{ pkgs, lib, ... }:
let
  genGitTarget = target: {
    name = ".talon/user/${target}";
    value = {
      url = "https://github.com/${target}.git";
      type = "git";
    };
  };
  talon_repos = [
    "talonhub/community"
    "david-tejada/rango-talon"
    "cursorless-dev/cursorless-talon"
    # chaosparrot talon_hud
    # suppressing talon_hud until it seems to be a better state
    # ProfDoof talon_hud
    "ProfDoof/speak-the-spire-talon"
    "ProfDoof/talon-files"
    "paul-schaaf/talon-filetree-commands"
  ];

in
{
  home.mutableFile = lib.listToAttrs (lib.map genGitTarget talon_repos);
  home.file = {
    ".talon/parrot" = {
      source = ./talon-parrot-model;
      recursive = true;
    };
  };
}
