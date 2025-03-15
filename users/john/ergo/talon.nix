{ pkgs, lib, ... }:
let
  genTarget = target: {
    name = ".talon/user/${target.repo}";
    value = {
      source = pkgs.fetchFromGitHub {
        owner = target.owner;
        repo = target.repo;
        rev = target.rev;
        sha256 = target.hash;
      };
      recursive = true;
    };
  };
  talon_repos = (lib.importTOML ./talon_repos.toml).talon_repos;

in
{
  # home.mutableFile = {

  # };
  home.file = lib.listToAttrs (lib.map genTarget talon_repos) // {
    ".talon/user/gamemode" = {
      source = ./gamemode;
      recursive = true;
    };
    ".talon/user/games" = {
      source = ./games;
      recursive = true;
    };
    ".talon/parrot" = {
      source = ./parrot/talon;
      recursive = true;
    };
    ".talon/user/parrot" = {
      source = ./parrot/user;
      recursive = true;
    };
    ".talon/user/override" = {
      source = ./override;
      recursive = true;
    };
    ".talon/user/sleep" = {
      source = ./sleep;
      recursive = true;
    };
  };
}
