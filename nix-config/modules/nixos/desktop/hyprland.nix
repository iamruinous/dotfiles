{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs) hyprland-qtutils hyprshell walker;
in {
  imports = [
    ./hyprland-packages.nix
  ];

  environment.systemPackages = with pkgs; [
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprland-qtutils.packages."${pkgs.system}".default
    hyprshell.packages.${pkgs.system}.default
    walker.packages.${pkgs.system}.default
  ];

  # Input settings
  services.libinput.enable = true;

  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;

  # Enable the Hyprland DM
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.xserver.updateDbusEnvironment = true;
  # Enable security services
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  security.pam.services = {
    hyprlock = {};
    gdm.enableGnomeKeyring = true;
  };
}
