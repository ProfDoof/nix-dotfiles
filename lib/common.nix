
{
  modules = inputs: with inputs; [
    {
      nix.settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        extra-substituters = [
          "https://cache.nixos.org/"
          "https://cosmic.cachix.org/"
          "https://nixpkgs-wayland.cachix.org/"
          "https://nix-community.cachix.org/"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
          "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    }
    (
      { pkgs, config, ... }:
      {
        # Allow unfree packages
        config.nixpkgs = {
          config.allowUnfree = true;
          overlays = [
            fenix.overlays.default
            nix-vscode-extensions.overlays.default
          ];
        };
      }
    )
  ];
}