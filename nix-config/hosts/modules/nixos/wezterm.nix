{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs) wezterm;
in {
  programs.wezterm = {
    enable = true;
    package = wezterm.packages.${pkgs.system}.default;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
}
