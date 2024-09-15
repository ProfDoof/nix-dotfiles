homeDir:
{
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.john = (import ../users/john/home.nix homeDir);
    };
    users.users.john.home = homeDir;
}