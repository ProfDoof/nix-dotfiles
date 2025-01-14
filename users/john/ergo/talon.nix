{ pkgs, lib, ... }:
let 
  genTarget = target:
  { 
    name=".talon/user/${target.repo}"; 
    value = {
      source = pkgs.fetchFromGitHub {
        owner = repo.owner;
        repo = repo.repo;
        rev = repo.rev;
        hash = repo.hash;
      };
      recursive = true;
    };
  };
  talon_repos = (lib.importToml ./talon_repos.toml).talon_repos;

in
{
  

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
  };
}
