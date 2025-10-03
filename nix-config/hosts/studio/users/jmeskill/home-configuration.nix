{flake, ...}: {
  imports = [
    flake.homeModules.default
    # flake.homeModules.darwin
  ];

  # Enable todoist
  services.todoist-auto.enable = true;

  # Enable vdirsyncer
  services.vdirsyncer-auto.enable = true;

  # Ensure homebrew is in the PATH
  home.sessionPath = [
    "/usr/local/homebrew/bin/"
  ];

  xdg.configFile.aerospace.source = ./aerospace.toml;

  home.stateVersion = "25.05";
}
#   imports = [
#     ../modules/common.nix
#     ../modules/desktop.nix
#     ../modules/ssh-interactive.nix
#     ../modules/darwin/common.nix
#     ../modules/darwin/aerospace-default.nix
#   ];
#

