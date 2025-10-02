{...}: let
  borders_config = ../../../files/configs/borders;
in {
  xdg.configFile = {
    "borders" = {
      source = "${borders_config}";
      recursive = true;
    };
  };
}
