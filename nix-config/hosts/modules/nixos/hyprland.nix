{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs) hyprswitch walker hyprland-qtutils;
in {
  # Input settings
  services.libinput.enable = true;

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    excludePackages = with pkgs; [xterm];
    displayManager.gdm.enable = true;
  };

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

  environment.systemPackages = with pkgs; [
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprswitch.packages.${pkgs.system}.default
    walker.packages.${pkgs.system}.default
    hyprland-qtutils.packages."${pkgs.system}".default
  ];

  # Fonts configuration
  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.bigblue-terminal
    pkgs.nerd-fonts.droid-sans-mono
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.monaspace
  ];
}
