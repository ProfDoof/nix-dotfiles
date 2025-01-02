{
  inputs = {
    # I rely on unstable as I prefer the interface and many of the packages I use also rely on it.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # This gives me access to the cosmic desktop environment from System76. Eventually this will be replaced by a nixpkgs pkg
    # or a System76 official one.
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # How I manage the home directories for the users on every one of my machines.
    # TODO: Allow for aliases for users to allow it to work on machines that I have less control over
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # The tools I leverage to use the most recent versions of wlroots that haven't made it to nixpkgs yet.
    # TODO: Do I really need this anymore? I might go back to Hyprland or Sway eventually but right now they just
    # don't play nicely with my NVIDIA GPU
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # A set of packages for rust and rust associated tooling.
    # TODO: Should I be using an overlay on this? Is that dangerous?
    fenix = {
      url = "github:andresilva/fenix/fix-platforms";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # This makes my mac play nicely with Nix so I can manage all my mac dependencies with nix as well.
    # TODO: Check and see whether or not there are workarounds to get things that don't work on mac onto mac anyway.
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Eventually the plan is to use this to have a declarative definition of my talon set-up that can be used on any machine
    # I use. In particular, I'd like for this to play nicely with crafting my own talon files but also pull down community talon
    # files.
    talon-nix = {
      url = "github:ProfDoof/talon-nix/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # An absolute necessity for my mac apps. This generates trampoline files in the Apps directories for my Nix mac apps
    # that are then indexed by spotlight. Without this, spotlight can't see the nix apps and I can't launch them from spotlight
    mac-app-util = {
      url = "github:hraban/mac-app-util";
    };

    # A tool to allow me to generate appropriate dev-shells for working on my dotfiles for most systems.
    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    # Formatter library
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Extended VSCode Extensions input.
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-darwin = {
      url = "github:bandithedoge/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    nix-alien.url = "github:thiagokokada/nix-alien";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-cosmic,
      home-manager,
      nixpkgs-wayland,
      fenix,
      nix-darwin,
      mac-app-util,
      flake-utils,
      treefmt-nix,
      nix-vscode-extensions,
      talon-nix,
      firefox-darwin,
      ...
    }@inputs:
    let
      dotlib = import ./lib/default.nix inputs;
      # Eventually the common modules, darwin modules, and nixos modules, I think I would like broken out into their own files
      # and then I want to somehow just add requirements to the modules to specify that they are only for NixOS or only for
      # Darwin, or only for Home-Manager. However, I need to understand the module system better for that. I'm currently
      # thinking that the way to go might be something like a module option that allows a host to specify the OS they expect
      # to be running. Then, the modules can opt-in or out to being included. After that, the system can create the correct
      # type of configuration. Whether that be a Darwin Config, a Nixos Config, or a Home Manager Config.
      commonModules = dotlib.common.modules;
      darwinModules = commonModules ++ [
        ./os/darwin.nix
        talon-nix.darwinModules.default
        mac-app-util.darwinModules.default
        # I'd really like this to be a bit dryer in conjuction with the nixosModules version of this code down below.
        # It just feels weird that I have basically the same code except for a couple of specific details.
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.sharedModules = [ mac-app-util.homeManagerModules.default ];
          home-manager.users.john.imports = [
            ./users/john/darwin.nix
            ./private/users/john/darwin.nix
          ];
          users.users.john.home = "/Users/john";
        }
        (
          { pkgs, config, ... }:
          {
            config.nixpkgs.overlays = [
              firefox-darwin.overlay
            ];
          }
        )
      ];
      nixOsModules = commonModules ++ [
        ./os/nixos.nix
        talon-nix.nixosModules.default
        nixos-cosmic.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.john.imports = [
            ./users/john/nixos.nix
            ./private/users/john/nixos.nix
          ];
        }
        (
          { self, system, pkgs, config, ... }:
          {
            environment.systemPackages = with self.inputs.nix-alien.packages.${system}; [
              nix-alien
            ];
            # Optional, needed for `nix-alien-ld`
            programs.nix-ld.enable = true;
            config.nixpkgs.overlays = [
              nixpkgs-wayland.overlay
            ];
          }
        )
      ];
      # Ideally this will turn into a helper function for a more feature complete function.
      getHosts = dotlib.common.getHosts [
        ./hosts
        ./private/hosts
      ];
    in
    {
      nixosConfigurations =
        nixpkgs.lib.mapAttrs
          # One thing to consider in the future is whether I want to also pass in the inputs so that my
          # modules can leverage the info those bring in.
          (
            _: hostModules:
            nixpkgs.lib.nixosSystem rec {
              system = "x86_64-linux";
              specialArgs = { inherit self system; };
              modules = hostModules ++ nixOsModules;
            }
          )
          (getHosts "nixos");
      darwinConfigurations = nixpkgs.lib.mapAttrs (
        _: hostModules:
        nix-darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = hostModules ++ darwinModules;
        }
      ) (getHosts "darwin");
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        treefmtWrapper = treefmt-nix.lib.mkWrapper pkgs ./treefmt.nix;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nil
            bashInteractive
            python3
            pipx
            ruff
          ];
        };

        formatter = treefmtWrapper;
      }
    );
}
