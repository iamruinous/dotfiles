{pkgs, ...}: {
  imports = [
    ./hyprland-packages.nix
  ];

  # Input settings
  services.libinput.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

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
