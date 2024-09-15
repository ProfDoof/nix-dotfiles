{ lib, ... }:
let
    inherit (lib) types mkOption;
    userType =  types.submodule {
        options = {
            createHome = mkEnableOption "home creation";
        };
    };

    nix-darwinType = types.submodule {
                            options = {
                                chipType = mkOption {
                                    type = types.enum [
                                        "intel"
                                        "arm"
                                    ];
                                };
                            };
                        };

    hostType = types.submodule {
        options = {
            hostType = mkOption {
                type = types.attrTag {
                    nixos = mkOption {
                        description = "A host running NixOS that needs the correct NixOS modules included";
                        type = types.submodule {};
                    };

                    home-manager = mkOption {
                        description = "A host that only has home-manager";
                        type = types.submodule {};
                    };
                    
                    nix-darwin = mkOption {
                        description = "A host running MacOS and nix-darwin that needs the correct darwin modules included";
                        type = nix-darwinType;
                    };
                };
            };

            homeDir = mkOption {
                description = "The directory to create home folders in";
                type = types.path;
            };

            users = mkOption {
                type = types.attrsOf userType;
            };
        };
    };
in
{
    options = {
        dotfiles.host = mkOption {
            type = hostType;
        };
    };
    config = {

    };
}