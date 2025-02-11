# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, inputs, ... }:
let
  inherit (inputs) wezterm hyprswitch walker;
in
{
  imports = [
    inputs.hardware.nixosModules.framework-intel-core-ultra-series1

    ./hardware-configuration.nix
    ../modules/common.nix
    ../modules/developer.nix
    ../modules/nixos/common.nix
    ../modules/nixos/latest-kernel.nix
    ../modules/nixos/print.nix
    ../modules/nixos/sudoless.nix
    ../modules/nixos/docker.nix
    ../modules/nixos/user.nix
    ../modules/nixos/kde.nix
    ../modules/nixos/pipewire.nix
    ../modules/nixos/steam.nix
    ../modules/nixos/tailscale.nix
  ];

  networking.hostName = "framework"; # Define your hostname.

  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.systemd-boot.xbootldrMountPoint = "/boot";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    sbctl
    fastfetch
    google-chrome
    wezterm.packages.${pkgs.system}.default
    kdePackages.merkuro
    obsidian
    todoist-electron
    dwarf-fortress
    gcc
    kitty
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprswitch.packages.${pkgs.system}.default
    walker.packages.${pkgs.system}.default
  ];

  # Enable login with fingerprint reader
  security.pam.services.login.fprintAuth = true;

  # Enable the 1Password CLI, this also enables a SGUID wrapper so the CLI can authorize against the GUI app
  programs._1password = {
    enable = true;
  };

  # Enable the 1Passsword GUI with myself as an authorized user for polkit
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "jmeskill" ];
  };

  # Enable the Hyprland DM
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable the UWSM
  # programs.uwsm = {
  #   enable = true;
  #   waylandCompositors = "hyprland";
  # };

  services.xserver.updateDbusEnvironment = true;
  # Enable security services
  security.polkit.enable = true;
  security.pam.services = {
    hyprlock = { };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
