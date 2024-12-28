flake_path=$1;
darwin-rebuild switch --flake "${flake_path}?submodules=1";