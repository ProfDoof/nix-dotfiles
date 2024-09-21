{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lean4
  ];
}
