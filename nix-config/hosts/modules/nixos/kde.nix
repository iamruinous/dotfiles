{pkgs, ...}: {
  # Input settings
  services.libinput.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    extraPackages = with pkgs; [
      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
    ];
    theme = "sddm-astronaut-theme";
  };

  environment.systemPackages = with pkgs; [
    kdePackages.oxygen
    kdePackages.krohnkite
    (sddm-astronaut.override
      {
        embeddedTheme = "pixel_sakura";
      })
  ];
}
