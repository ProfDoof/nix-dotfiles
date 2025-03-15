#!/bin/zsh
flake_path=$1

darwin-rebuild switch --show-trace --flake "${flake_path}?submodules=1"
