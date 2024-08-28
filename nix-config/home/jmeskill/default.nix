{ config, pkgs, lib, unstablePkgs, ... }:
{
  imports = [
      ./../common/chezmoi.nix
      ./packages.nix
      ./fish.nix
      # ./neovim.nix
      ./ssh-hosts.nix
    ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  }; 

  # programs.gpg.enable = true;

  programs.keychain = {
    enable = true;
    inheritType = "any-once";
    extraFlags = [
      "--ignore-missing"
      "--quiet"
    ];
    agents = [
      "ssh"
      # "gpg"
    ];
    keys = [
      "~/.ssh/id_ed25519"
      "~/.ssh/id_jademeskill_ed25519"
      "~/.ssh/id_ruinous_computer_ed25519"
      "~/.ssh/id_rsa"
      # "00AB98E4EDFA6211"
      # "CA5500A8F3A920A0"
    ];
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableTransience = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

}
