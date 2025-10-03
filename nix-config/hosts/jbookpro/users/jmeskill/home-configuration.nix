{flake, ...}: {
  imports = [flake.homeModules.home-shared];
  home.stateVersion = "25.05";
}
