{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, nixos-cosmic, home-manager }: 
    let
      inherit (nixpkgs) lib;
    in
    {
      nixosConfigurations = 
        let
          modules = [
            nixos-cosmic.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.john = import ./users/john/home.nix;
            }
          ];
          hosts = (
            lib.filterAttrs
              (host: type: type == "directory" && builtins.pathExists (./hosts + "/${host}/configuration.nix"))
              (builtins.readDir ./hosts)
          );
        in
        lib.mapAttrs
          (host: _: lib.nixosSystem {
            system = "x86_64-linux";
            modules = modules ++ [
              ./hosts/${host}/configuration.nix
            ];
          })
          hosts;
      
    };
}
