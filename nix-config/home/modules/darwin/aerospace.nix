{ ... }:
let
  aerospace_config = ../../../files/configs/aerospace;
in
{
  xdg.configFile = {
    "aerospace" = {
      source = "${aerospace_config}";
      recursive = true;
    };
  };
}
