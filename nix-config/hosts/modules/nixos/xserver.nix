{pkgs, ...}: {
  # Enable the X11 windowing system.
  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    excludePackages = with pkgs; [xterm];
  };
}
