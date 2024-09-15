{
    nixos-cosmic, home-manager, ...
}:
{
    modules = [
        nixos-cosmic.nixosModules.default
        (home-manager.nixosModules.home-manager (import ./home-manager.nix "/home/john"))
        (
            { pkgs, config, ... }:
            {
                config.nixpkgs.overlays = [
                    nixpkgs-wayland.overlay
                ];
            }
        )
    ];
}