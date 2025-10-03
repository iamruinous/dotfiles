{
  lib,
  pkgs,
  ...
}: {
  programs = {
    steam = {
      enable = lib.mkDefault true;
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            gamemode # Conditionally when `programs.gamemode.enable` is set.
          ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    lutris
    heroic
  ];

  # programs.gamescope.enable = true;
  programs.gamemode.enable = true;
}
