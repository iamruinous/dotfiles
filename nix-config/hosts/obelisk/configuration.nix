# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstablePkgs, lib, inputs, ... }:
let
  inherit (inputs) wezterm;
in
{
  imports = [
    ./hardware-configuration.nix
    ../modules/common.nix
    ../modules/developer.nix
    ../modules/nixos/common.nix
    ../modules/nixos/print.nix
    ../modules/nixos/sudoless.nix
    ../modules/nixos/docker.nix
    ../modules/nixos/user.nix
    ../modules/nixos/hyprland.nix
    ../modules/nixos/pipewire.nix
    ../modules/nixos/steam.nix
    ../modules/nixos/tailscale.nix
    ../modules/nixos/ollama.nix
  ];

  networking.hostName = "obelisk"; # Define your hostname.

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    sbctl
    fastfetch
    google-chrome
    wezterm.packages.${pkgs.system}.default
    obsidian
    todoist-electron
    dwarf-fortress
    gcc
    kitty
    caddy
  ];

  # Enable the 1Password CLI, this also enables a SGUID wrapper so the CLI can authorize against the GUI app
  programs._1password = {
    enable = true;
  };

  # Enable the 1Passsword GUI with myself as an authorized user for polkit
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "jmeskill" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
