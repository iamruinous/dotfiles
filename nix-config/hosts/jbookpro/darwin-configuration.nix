{flake, ...}: {
  imports = [
    flake.darwinModules.default
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.jmeskill.home = /Users/jmeskill;
  system.primaryUser = "jmeskill";

  # this system has a battery
  programs.starship.settings.battery.disabled = false;

  system.stateVersion = 6;
}
