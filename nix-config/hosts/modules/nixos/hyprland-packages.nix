{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs) hyprland-qtutils hyprshell walker;
in {
  environment.systemPackages = with pkgs; [
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprland-qtutils.packages."${pkgs.system}".default
    hyprshell.packages.${pkgs.system}.default
    walker.packages.${pkgs.system}.default
  ];
}
