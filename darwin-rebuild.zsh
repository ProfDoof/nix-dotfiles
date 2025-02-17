#!/bin/zsh
flake_path=$1

cd "${flake_path}/users/john/ergo/" && ./update.zsh && cd -;

darwin-rebuild switch --show-trace --flake "${flake_path}?submodules=1"
