inputs: with inputs; {
  genFlags = system: {
    isDarwin = system == "darwin";
    isGenericLinux = system == "linux";
    isNixOS = system == "nixos";
  };
}
