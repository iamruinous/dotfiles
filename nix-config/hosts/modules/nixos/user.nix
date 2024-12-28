{ pkgs, userConfig, ... }: {
  # User configuration
  users.users.${userConfig.name} = {
    description = userConfig.fullName;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    isNormalUser = true;
    shell = pkgs.fish;
  };
}
