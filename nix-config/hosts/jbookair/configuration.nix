{ pkgs
, outputs
, userConfig
, ...
}: {
  imports = [
    ../modules/common.nix
    ../modules/developer.nix
    ../modules/darwin/common.nix
    ../modules/darwin/system.nix
    ../modules/darwin/touch.nix
    ../modules/darwin/user.nix
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 5;
}
