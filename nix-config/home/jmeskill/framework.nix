{...}: let
  wallpaper_dir = ../../files/wallpapers/nixos;
  workspace-wallpaper = "${wallpaper_dir}/pixel_sakura_static.png";
in {
  imports = [
    ../modules/common.nix
    ../modules/desktop.nix
    ../modules/ssh-interactive.nix
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Enable todoist
  services.todoist-auto.enable = true;

  # Enable vdirsyncer
  services.vdirsyncer-auto.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  programs.plasma = {
    enable = true;

    #
    # Some high-level settings:
    #
    workspace.wallpaper = "${workspace-wallpaper}";
    kscreenlocker.appearance.wallpaper = "${workspace-wallpaper}";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
