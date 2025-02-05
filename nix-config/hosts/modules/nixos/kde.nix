{ pkgs, ... }: {
  # Input settings
  services.libinput.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Fonts configuration
  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.bigblue-terminal
    pkgs.nerd-fonts.droid-sans-mono
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.monaspace
  ];
}
