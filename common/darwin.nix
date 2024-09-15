{
    home-manager, ...
}:
{
    modules = [
        home-manager.darwinModules.home-manager (import ./home-manager.nix "/Users/john")
    ];
}