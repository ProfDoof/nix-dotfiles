{
  self,
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    vim
  ];

  services = {
    nix-daemon.enable = true;
  };

  nix.settings.experimental-features = "nix-command flakes";

  programs = {
    zsh.enable = true;
  };

  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 5;
  };

  nixpkgs.hostPlatform = "x86_64-darwin";
}
