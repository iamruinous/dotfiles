{ age, config, pkgs, ... }: {
  # Install vidrsyncer via home-manager module
  home.packages = [
    pkgs.vdirsyncer
  ];
  # programs.vdirsyncer = {
  #   enable = true;
  # };

  age.secrets.vdirsyncer_config = {
    file = ../../files/configs/vdirsyncer/config.age;
    path = "${config.home.homeDirectory}/.config/vdirsyncer/config";
    mode = "600";
  };
}
