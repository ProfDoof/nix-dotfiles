{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [

    ];

    # Auto upgrade nix package and the daemon service.
    programs.zsh.enable = true;
    programs.fish.enable = true;
    services.nix-daemon.enable = true;
    nix.package = pkgs.nix;
    nixpkgs.hostPlatform = "x86_64-darwin";
    system.stateVersion = 5;
}