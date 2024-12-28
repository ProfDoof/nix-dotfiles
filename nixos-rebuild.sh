flake_path=$1;
nixos-rebuild switch --flake "${flake_path}?submodules=1";