{ pkgs, ... }:
{
  imports = [
    ../../host.nix
  ];
  environment.systemPackages = with pkgs; [
    docker
  ];
}
