#!/bin/zsh
flake_path=$1
nixos-rebuild switch --show-trace --flake "${flake_path}?submodules=1"
