{...}: let
  editorconfig_config = ../../../files/configs/editorconfig;
in {
  home.file = {
    ".editorconfig" = {
      source = "${editorconfig_config}";
    };
  };
}
