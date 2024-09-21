{ ... }:
{
  programs.helix.settings = {
    theme = "void";
    editor = {
      line-number = "relative";
      gutters = [
        "diagnostics"
        "spacer"
        "line-numbers"
        "spacer"
        "diff"
      ];
      rulers = [
        120
      ];
      bufferline = "always";
      cursorline = true;
      cursorcolumn = true;

      cursor-shape = {
        insert = "bar";
      };

      file-picker = {
        hidden = true;
        git-ignore = true;
      };

      whitespace = {
        render = "all";
      };

      indent-guides = {
        render = true;
        character = "|";
      };

      lsp = {
        display-inlay-hints = true;
        display-messages = true;
      };
    };
  };
}
