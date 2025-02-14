{pkgs, ...}: {
  imports = [
    ./brew.nix
    ./fonts.nix
    ./system.nix
    ./touch.nix
    ./user.nix
  ];

  nix.package = pkgs.nix;

  # Enable Nix daemon
  services.nix-daemon.enable = true;
}
