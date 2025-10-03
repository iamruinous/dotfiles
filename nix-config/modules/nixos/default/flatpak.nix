{
  lib,
  pkgs,
  ...
}: {
  services.flatpak.enable = lib.mkDefault true;

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.config.common.default = "gtk";
  services.flatpak.overrides. global = {
    # Force Wayland by default
    Context.sockets = ["wayland" "!x11" "!fallback-x11"];

    Environment = {
      # Fix un-themed cursor in some Wayland apps
      XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

      # Force correct theme for some GTK apps
      GTK_THEME = "Adwaita:dark";
    };
  };

  services.flatpak.uninstallUnmanaged = true;
  services.flatpak.update.onActivation = true;
  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly"; # Default value
  };
  services.flatpak.packages = [
    "com.spotify.Client"
  ];
}
