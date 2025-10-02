{pkgs, ...}: {
  nix.package = pkgs.nix;

  # disable for Determinate Nix
  nix.enable = false;

  # direnv configuration
  programs.direnv.enable = true;

  # Add ability to use TouchID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # default system packages
  environment.systemPackages = with pkgs; [
    jankyborders
  ];
}
