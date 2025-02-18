{pkgs, ...}: {
  # Input settings
  services.libinput.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.extraPackages = with pkgs; [
    kdePackages.qtsvg
    kdePackages.qtmultimedia
    kdePackages.qtvirtualkeyboard
  ];
  services.displayManager.sddm.theme = "sddm-astronaut-theme";
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    (sddm-astronaut.override
      {
        embeddedTheme = "pixel_sakura";
      })
  ];
}
