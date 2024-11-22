{ pkgs, ... }:

{
  home.file = {
    ".talon/user/community" = {
      source = pkgs.fetchFromGitHub {
        owner = "talonhub";
        repo = "community";
        rev = "bb240ba1cf958bd3e2c7791e5a57d09d205adc81";
        hash = "";
      };
      recursive = true;
    };
    ".talon/user/rango" = {
      source = pkgs.fetchFromGitHub {
        owner = "david-tejada";
        repo = "rango-talon";
        rev = "609641f8fe99fafe7e6f69441f60792fb7c51b60";
        hash = "";
      };
      recursive = true;
    };
    ".talon/user/cursorless" = {
      source = pkgs.fetchFromGitHub {
        owner = "cursorless-dev";
        repo = "cursorless-talon";
        rev = "0aba9e01299637655c7ca11cba7c99b965a1a488";
        hash = "";
      };
      recursive = true;
    };
    ".talon/user/talon_hud" = {
      source = pkgs.fetchFromGitHub {
        owner = "chaosparrot";
        repo = "talon_hud";
        rev = "0d676565b95f34841d7268b3667b4b780e50cfaa";
        hash = "";
      };
      recursive = true;
    };
    
  };
}
