{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs) hyprswitch walker;
in {
  environment.systemPackages = with pkgs; [
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprland-qtutils.packages."${pkgs.system}".default
    hyprswitch.packages.${pkgs.system}.default
    walker.packages.${pkgs.system}.default
  ];
}
