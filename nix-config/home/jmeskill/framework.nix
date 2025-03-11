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
    window-rules = [
      {
        description = "Google Chrome";
        match = {
          window-class = {
            value = "google-chrome";
            type = "exact";
            match-whole = false;
          };
        };
        apply = {
          desktops = {
            value = "d13a21da-3d8e-4629-a57a-2a89103e3008";
            apply = "initially";
          };
        };
      }
      {
        description = "WezTerm";
        match = {
          window-class = {
            value = "org.wezfurlong.wezterm";
            type = "exact";
            match-whole = false;
          };
        };
        apply = {
          desktops = {
            value = "9f6f84c9-757f-48e8-ad21-92cc205d698f";
            apply = "initially";
          };
        };
      }
      {
        description = "Todoist";
        match = {
          window-class = {
            value = "Todoist";
            type = "exact";
            match-whole = false;
          };
        };
        apply = {
          desktops = {
            value = "335dc1e0-a72a-404a-bfb7-d8587fe250e2";
            apply = "initially";
          };
        };
      }
      {
        description = "Steam";
        match = {
          window-class = {
            value = "steam";
            type = "exact";
            match-whole = false;
          };
        };
        apply = {
          desktops = {
            value = "85da5de8-7ca5-4938-a8ee-4920a0e4d659";
            apply = "initially";
          };
        };
      }
      {
        description = "Glance";
        match = {
          window-class = {
            value = "chrome-ljlamgbgefobjkjkepgbmbebcoaheadj-Default";
            type = "exact";
            match-whole = false;
          };
        };
        apply = {
          desktops = {
            value = "ebdb614a-d1a5-4560-9e8c-66a27734a829";
            apply = "initially";
          };
        };
      }
    ];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
