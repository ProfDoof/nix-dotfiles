{ ... }:
{
  programs.helix.languages = {
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
        config.settings.args = [
          "--ignore"
          "E501"
        ];
      };
    };
    language = [
      {
        name = "fsharp";
        scope = "source.fs";
        roots = [
          "sln"
          "fsproj"
        ];
        injection-regex = "fsharp";
        file-types = [
          "fs"
          "fsx"
        ];
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

      {
        name = "toml";
        auto-format = true;
        formatter = {
          command = "taplo";
          args = [
            "fmt"
            "-"
          ];
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
}
