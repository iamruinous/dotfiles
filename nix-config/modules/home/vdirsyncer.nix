{
  config,
  flake,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.vdirsyncer
  ];

  imports = [
    flake.inputs.agenix.homeManagerModules.default
  ];

  age.secrets.vdirsyncer_config = {
    file = ../../files/configs/vdirsyncer/config.age;
    path = "${config.home.homeDirectory}/.config/vdirsyncer/config";
    mode = "600";
  };
}
