{
  lib,
  pkgs,
  config,
  ...
}: {
  # Docker configuration
  virtualisation.docker.enable = lib.mkDefault true;
  # virtualisation.docker.rootless.enable = true;
  # virtualisation.docker.rootless.setSocketVariable = true;
  users.users.${config.system.primaryUser}.extraGroups = ["docker"];

  environment.systemPackages = with pkgs; [
    arion
    lazydocker
  ];
}
