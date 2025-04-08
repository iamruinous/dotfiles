{pkgs, ...}: {
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

  # direnv configuration
  programs.direnv.enable = true;
}
