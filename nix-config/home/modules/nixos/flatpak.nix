{
  lib,
  pkgs,
  ...
}: {
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.config.common.default = "gtk";

  services.flatpak.update.onActivation = true;
  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly"; # Default value
  };
  services.flatpak.packages = [
    "com.spotify.Client"
  ];
}
