{...}: {
  imports = [
    ../modules/common.nix
    ../modules/desktop.nix
    ../modules/nixos/hyprland.nix
    ../modules/devenv.nix
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Enable todoist
  services.todoist-auto.enable = true;

  # Enable vdirsyncer
  services.vdirsyncer-auto.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
