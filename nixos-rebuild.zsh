#!/usr/bin/env zsh
flake_path=$1
sudo nixos-rebuild switch --show-trace --flake "${flake_path}?submodules=1"
