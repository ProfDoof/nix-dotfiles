{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "John Marsden";
    userEmail = "john@johnmarsden.dev";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };

    # includes = [
    #   {
    #     condition = "gitdir:~/git/<username>/";
    #     contents = {
    #       user = {
    #         name = ""
    #       }
    #     };
    #   }
    # ];
  };
}
