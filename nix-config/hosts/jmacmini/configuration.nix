{ ... }: {
  imports = [
    ../modules/common.nix
    ../modules/developer.nix
    ../modules/darwin/common.nix
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 5;
}
