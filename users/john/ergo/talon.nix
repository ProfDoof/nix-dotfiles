{ pkgs, ... }:

{
  home.file = {
    ".talon/user/community" = {
      source = pkgs.fetchFromGitHub {
        owner = "talonhub";
        repo = "community";
        rev = "bb240ba1cf958bd3e2c7791e5a57d09d205adc81";
        hash = "sha256-Nnpm2d/2BQruT40fx2hzVvGkeDda8pPgx84rclHoOsA=";
      };
      recursive = true;
    };
    ".talon/user/rango" = {
      source = pkgs.fetchFromGitHub {
        owner = "david-tejada";
        repo = "rango-talon";
        rev = "609641f8fe99fafe7e6f69441f60792fb7c51b60";
        hash = "sha256-cyJkRZrOn2zrdi+roSOKDeLJjd/Bxk+Ra4lWreGqq+4=";
      };
      recursive = true;
    };
    ".talon/user/cursorless" = {
      source = pkgs.fetchFromGitHub {
        owner = "cursorless-dev";
        repo = "cursorless-talon";
        rev = "0aba9e01299637655c7ca11cba7c99b965a1a488";
        hash = "sha256-aAr4EVE3E3KjGgHcw/ruYmfi3wXKLhPYhHvOC2eQDPE=";
      };
      recursive = true;
    };
    ".talon/user/talon_hud" = {
      source = pkgs.fetchFromGitHub {
        owner = "chaosparrot";
        repo = "talon_hud";
        rev = "0d676565b95f34841d7268b3667b4b780e50cfaa";
        hash = "sha256-/uUZkh0SH/rh4jkNbTnZAJplZWHexRXQhVldwI0Gl7k=";
      };
      recursive = true;
    };
    ".talon/user/speak-the-spire-talon" = {
      source = pkgs.fetchFromGitHub {
        owner = "ProfDoof";
        repo = "speak-the-spire-talon";
        rev = "fd8a2cc9af6d968bf6134994fcef8b3f9df4f40b";
        hash = "sha256-K6LcQKH7Js1umnweiD/tbulfk9m1WrfAp+UHIVIvCns=";
      };
      recursive = true;
    };
    ".talon/user/gamemode" = {
      source = ./gamemode;
      recursive = true;
    };
    ".talon/user/games" = {
      source = ./games;
      recursive = true;
    };
  };
}
