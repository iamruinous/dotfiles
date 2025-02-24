{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./brew.nix
    ./fonts.nix
    ./system.nix
    ./touch.nix
    ./user.nix
  ];

  nix.package = pkgs.nix;

  # disable for Determinate Nix
  nix.enable = false;

  # ids.uids.nixbld = lib.mkForce 350;

  # direnv configuration
  programs.direnv.enable = true;
}
