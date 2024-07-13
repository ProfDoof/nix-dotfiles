{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dotnet-sdk
    fsautocomplete
    nil
    nixpkgs-fmt
  ];
  
  programs.helix = {
    enable = true;
    settings = {
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
    languages = {
      language-server = {
        fsharp-lsp = {
          command = "fsautocomplete";
          config.AutomaticWorkspaceInit = true;
        };

        texlab.config.texlab = {
          build.onSave = true;
          inlayHints = {
            labelDefinitions = true;
            labelReferences = true;
          };
        };

        rust-analyzer.config = {
          check.command = "clippy";
          cargo.autoreload = true;
        };

        pyright.config.python.analysis.typeCheckingMode = "strict";

        ruff = {
          command = "ruff-lsp";
          config.settings.args = ["--ignore" "E501"];
        };
      };
      language = [
        {
          name = "fsharp";
          scope = "source.fs";
          roots = [ "sln" "fsproj" ];
          injection-regex = "fsharp";
          file-types = [ "fs" "fsx" ];
          comment-token = "//";
          indent = {
            tab-width = 4;
            unit = "    ";
          };
          auto-format = true;
          language-servers = [ "fsharp-lsp" ];
        }

        {
          name = "go";
          auto-format = true;
          formatter = { 
            command = "goimports";
          };
        }

        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixpkgs-fmt";
          };
        }
      ];

      grammar = [
        {
          name = "fsharp";
          source = {
            git = "https://github.com/kaashyapan/tree-sitter-fsharp";
            rev = "18da392fd9bd5e79f357abcce13f61f3a15e3951";
          };
        }
      ];
    };
    themes = {
      void = let 
        black = "#000000";
        white = "#ffffff";
        void = "#0f0321";
        twilight = "#530ca5";
        sun = "#f5f226";
        betelgeuse = "#eb391c";
        sirius_b = "#2d49ff";
        light_sirius_b = "#6075ff";
        deep_sirius_b = "#162480";
        centaurii = "#b26aff";
        sirius = "#b5f8fe";
        cygni = "#ff985d";
        hacker = "#34ab1b";
        dull_hacker = "#268014";
        beta_centaurii = "#268014";
        unfocused = "#5e5e5e";
        deep_blue = "#12083d";
        dull_sirius = "#455e61";
        dull_void = "#1a1521";
        trick = "#b817a9";
        light_centaurii = "#c37fc0";
        # dull_twilight = "#2f1f42";
      in {
        # UI Color Definitions
        "ui.background" = { 
          fg = beta_centaurii; 
          bg = void; 
        };
        "ui.background.separator" = { 
          fg = beta_centaurii; 
        };
        "ui.cursor" = { 
          bg = centaurii; 
          modifier = [ "slow_blink" ]; 
        };
        "ui.cursor.match" = { 
          fg = centaurii; 
          underline = {
            style = "line"; 
          }; 
        };
        "ui.cursor.primary" = { 
          bg = twilight;
        };
        "ui.debug.breakpoint" = { 
          fg = betelgeuse; 
        };
        "ui.debug.active" = { 
          fg = sun; 
        };
        "ui.gutter" = {
          bg = beta_centaurii; 
        };
        "ui.gutter.selected" = { 
          fg = sirius_b; 
          bg = sirius_b; 
        };
        "ui.linenr" = { 
          fg = sirius; 
        };
        "ui.linenr.selected" = { 
          fg = sirius; 
          bg = sirius_b; 
        };
        "ui.statusline" = { 
          fg = sirius; 
          bg = twilight; 
        };
        "ui.statusline.inactive" = { 
          fg = void; 
          bg = unfocused; 
        };
        "ui.statusline.separator" = { 
          fg = sirius;
        };
        "ui.popup" = { 
          bg = deep_blue; 
          fg = white;
        };
        "ui.popup.info" = { 
          bg = beta_centaurii;
        };
        "ui.window" = {
          bg = deep_blue; 
          fg = sirius;  
        };
        "ui.help" = { 
          bg = deep_blue; 
          fg = sirius;  
        };
        "ui.text" = { 
          fg = sirius;  
        };
        "ui.text.focus" = { 
          fg = sun; 
          modifiers = ["bold"]; 
        };
        "ui.text.inactive" = { 
          fg = dull_sirius;  
        };
        "ui.text.info" = { 
          fg = sirius; 
        };
        "ui.virtual.ruler" = { 
          bg = dull_sirius;  
        };
        "ui.virtual.whitespace" = { 
          fg = dull_sirius;  
        };
        "ui.virtual.indent-guide" = { 
          fg = dull_sirius;  
        };
        "ui.virtual.inlay-hint" = { 
          fg = dull_sirius;  
        };
        "ui.virtual.inlay-hint.parameter" = { 
          fg = light_sirius_b; 
          bg = black;  
        };
        "ui.virtual.inlay-hint.type" = { 
          fg = light_sirius_b; 
          bg = black;  
        };
        "ui.virtual.wrap" = { 
          fg = dull_sirius;  
        };
        "ui.menu" = { 
          fg = sirius; 
          bg = dull_void; 
        };
        "ui.menu.selected" = { 
          fg = sirius; 
          bg = twilight;  
        };
        "ui.menu.scroll" = { 
          fg = betelgeuse; 
          bg = sun;  
        };
        "ui.selection" = { 
          bg = deep_sirius_b; 
        };
        "ui.selection.primary" = { 
          bg = sirius_b; 
        };
        "ui.highlight" = { 
          fg = sun; 
          bg = deep_sirius_b;  
        };
        "ui.cursorline.primary" = { 
          bg = deep_blue;  
        };
        "ui.cursorline.secondary" = {
          bg = black;  
        };
        "ui.cursorcolumn.primary" = { 
          bg = deep_blue;  
        };
        "ui.cursorcolumn.secondary" = {
          bg = black;  
        };
        "warning" = { 
          fg = sun;  
        };
        "error" = { 
          fg = betelgeuse;  
        };
        "info" = { 
          fg = sirius_b;  
        };
        "hint" = { 
          fg = hacker;  
        };
        "diagnostic" = { 
          underline = { 
            color = cygni; 
            style = "curl"; 
          }; 
        };
        "diagnostic.warning" = { 
          underline = { 
            color = sun; 
            style = "curl"; 
          }; 
        };
        "diagnostic.error" = { 
          underline = { 
            color = betelgeuse; 
            style = "curl"; 
          }; 
        };
        "diagnostic.info" = { 
          underline = { 
            color = sirius_b; 
            style = "curl"; 
          }; 
        };
        "diagnostic.hint" = { 
          underline = { 
            color = hacker; 
            style = "curl"; 
          }; 
        };


        ## Need to be refined after the rest of the theme has been refined;
        "ui.statusline.normal" = { 
          fg = sirius; 
          bg = twilight;  
        };
        "ui.statusline.insert" = { 
          fg = sirius; 
          bg = twilight;  
        };
        "ui.statusline.select" = { 
          fg = sirius; 
          bg = twilight; 
        };

        # Tree Sitter Styling;
        "attribute" = { 
          fg = sun;  
        };
        "type" = { 
          fg = cygni; 
        };
        "type.builtin" = { 
          fg = trick;  
        };
        "type.enum" = { 
          fg = cygni;  
        };
        "type.enum.variant" = { 
          fg = sun;  
        };
        "constructor" = { 
          fg = cygni;  
        };
        "constant" = { 
          fg = light_sirius_b;  
        };
        "constant.builtin" = { 
          fg = light_sirius_b;  
        };
        "constant.builtin.boolean" = { 
          fg = light_sirius_b;  
        };
        "constant.character" = { 
          fg = centaurii;  
        };
        "constant.character.escape" = { 
          fg = sirius;  
        };
        "constant.numeric" = { 
          fg = light_sirius_b;  
        };
        # "constant.numeric.integer" = { fg = sirius;  };
        # "constant.numeric.float" = { fg = sirius;  };
        "string" = { 
          fg = centaurii;  
        };
        # "string.quoted" = { fg = sirius;  };
        # "string.quoted.single" = { fg = sirius;  };
        # "string.quoted.double" = { fg = sirius;  };
        # "string.raw" = { fg = sirius;  };
        # "string.unquoted" = { fg = sirius;  };
        "string.regexp" = { 
          fg = betelgeuse;  
        };
        "string.special" = { 
          fg = betelgeuse;  
        };
        # "string.special.path" = { fg = sirius;  };
        "string.special.url" = { 
          fg = hacker;  
        };
        # "string.special.symbol" = { fg = sirius;  };
        "comment" = { 
          fg = dull_hacker;  
        };
        "comment.line" = { 
          fg = dull_hacker;  
        };
        "comment.block" = { 
          fg = dull_hacker;  
        };
        "comment.block.documentation" = { 
          fg = light_centaurii;  
        };
        "variable" = { 
          fg = sun;  
        };
        "variable.builtin" = { 
          fg = cygni;  
        };
        "variable.parameter" = { 
          fg = sun;  
        };
        "variable.other" = { 
          fg = cygni;  
        };
        "variable.other.member" = { 
          fg = sun;  
        };
        "label" = { 
          fg = betelgeuse;  
        };
        "punctuation" = { 
          fg = sirius;  
        };
        "punctuation.delimiter" = { 
          fg = sirius;  
        };
        "punctuation.bracket" = { 
          fg = sirius;  
        };
        "punctuation.special" = { 
          fg = sirius;  
        };
        "keyword" = { 
          fg = sirius;  
        };
        "keyword.control" = { 
          fg = sirius;  
        };
        "keyword.control.conditional" = { 
          fg = sirius;  
        };
        "keyword.control.repeat" = { 
          fg = sirius;  
        };
        "keyword.control.import" = { 
          fg = sirius;  
        };
        "keyword.control.return" = { 
          fg = sirius;  
        };
        "keyword.control.exception" = { 
          fg = sirius;  
        };
        "keyword.operator" = { 
          fg = sirius;  
        };
        "keyword.directive" = { 
          fg = sirius;  
        };
        "keyword.function" = { 
          fg = sirius;  
        };
        "keyword.storage" = { 
          fg = sirius;  
        };
        "keyword.storage.type" = { 
          fg = sirius;  
        };
        "keyword.storage.modifier" = { 
          fg = sirius;  
        };
        "operator" = { 
          fg = sirius;  
        };
        "function" = { 
          fg = sirius;  
        };
        "function.builtin" = { 
          fg = sirius;  
        };
        "function.method" = { 
          fg = sirius;  
        };
        "function.macro" = { 
          fg = sirius;  
        };
        "function.special" = { 
          fg = sirius;  
        };
        "tag" = { 
          fg = sirius;  
        };
        "tag.builtin" = { 
          fg = sirius;  
        };
        "namespace" = { 
          fg = sirius;  
        };
        "special" = { 
          fg = sirius;  
        };
        "markup" = { 
          fg = sirius;  
        };
        "markup.heading" = { 
          fg = sirius;  
        };
        "markup.heading.marker" = { 
          fg = sirius;  
        };
        "markup.heading.1" = { 
          fg = sirius;  
        };
        "markup.heading.2" = { 
          fg = sirius;  
        };
        "markup.heading.3" = { 
          fg = sirius;  
        };
        "markup.heading.4" = { 
          fg = sirius;  
        };
        "markup.heading.5" = { 
          fg = sirius;  
        };
        "markup.heading.6" = { 
          fg = sirius;  
        };
        "markup.list" = { 
          fg = sirius;  
        };
        "markup.list.unnumbered" = { 
          fg = sirius;  
        };
        "markup.list.numbered" = { 
          fg = sirius;  
        };
        "markup.list.checked" = { 
          fg = sirius;  
        };
        "markup.list.unchecked" = { 
          fg = sirius;  
        };
        "markup.bold" = { 
          fg = sirius;  
        };
        "markup.italic" = { 
          fg = sirius;  
        };
        "markup.strikethrough" = { 
          fg = sirius;  
        };
        "markup.link" = { 
          fg = sirius;  
        };
        "markup.link.url" = { 
          fg = sirius;  
        };
        "markup.link.label" = { 
          fg = sirius;  
        };
        "markup.link.text" = { 
          fg = sirius;  
        };
        "markup.quote" = { 
          fg = sirius;  
        };
        "markup.raw" = { 
          fg = sirius;  
        };
        "markup.raw.inline" = { 
          fg = sirius;  
        };
        "markup.raw.block" = { 
          fg = sirius;  
        };
        "diff" = {   
          fg = sirius;  
        };
        "diff.plus" = { 
          fg = sirius;  
        };
        "diff.minus" = { 
          fg = sirius;  
        };
        "diff.delta" = { 
          fg = sirius;  
        };
        "diff.delta.moved" = { 
          fg = sirius;  
        };

        # Tree Sitter Scopes for Styling the Interface;
        "markup.normal" = { 
          fg = sirius; 
          bg = void;  
        };
        "markup.normal.completion" = { 
          fg = sirius; 
          bg = void;  
        };
        "markup.normal.hover" = { 
          fg = sirius; 
          bg = void;  
        };
        "markup.heading.hover" = { 
          fg = sirius; 
          bg = void;  
        };
        "markup.heading.completion" = { 
          fg = sirius; 
          bg = void;  
        };
        "markup.raw.inline.hover" = { 
          fg = sirius; 
          bg = void;  
        };
      };
    };
  };
}
