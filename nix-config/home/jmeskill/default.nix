{ config, pkgs, inputs, lib, ... }:
{
  imports = [
    inputs._1password-shell-plugins.hmModules.default
    inputs.agenix.homeManagerModules.default
    ./../common/chezmoi.nix
    ./fish.nix
    # ./neovim.nix
    ./packages.nix
    ./ssh-hosts.nix
    ./tmux.nix
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  #  launchd.agents.vdirsyncer = {
  #    enable = true;
  #    config = {
  #      ProgramArguments = [ "${pkgs.vdirsyncer}/bin/vdirsyncer" "sync" ];
  #      StartInterval = 900;
  #    };
  #  };

  # age.secrets.vdirsyncer = {
  #   file = ./secrets/vdirsyncer.age;
  #   path = "$HOME/.config/vdirsyncer/config";
  # };

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

  programs._1password-shell-plugins = {
    # enable 1Password shell plugins for bash, zsh, and fish shell
    enable = true;
    # the specified packages as well as 1Password CLI will be
    # automatically installed and configured to use shell plugins
    # plugins = with pkgs; [ gh awscli2 cachix ];
  };
}
