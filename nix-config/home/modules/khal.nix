{...}: let
  khal_config = ../../files/configs/khal/config;
in {
  # Install khal via home-manager module
  programs.khal = {
    enable = true;
  };

  xdg.configFile."khal/config".source = "${khal_config}";
}
