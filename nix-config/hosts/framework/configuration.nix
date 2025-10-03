# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.framework-intel-core-ultra-series1

    ./hardware-configuration.nix
    ../modules/common.nix
    ../modules/developer.nix
    ../modules/nixos/desktop-common.nix
    ../modules/nixos/docker.nix
    ../modules/nixos/flatpak.nix
    # ../modules/nixos/hyprland-packages.nix
    ../modules/nixos/kde.nix
    ../modules/nixos/latest-kernel.nix
    ../modules/nixos/restic.nix
    ../modules/nixos/steam.nix
  ];

  networking.hostName = "framework"; # Define your hostname.

  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    #    settings.reboot-for-bitlocker = true;
  };

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.systemd-boot.xbootldrMountPoint = "/boot";

  environment.systemPackages = with pkgs; [
    dwarf-fortress
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable login with fingerprint reader
  security.pam.services.login.fprintAuth = true;

  # Enable the Hyprland DM
  # programs.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  # };

  # Enable the UWSM
  # programs.uwsm = {
  #   enable = true;
  #   waylandCompositors = "hyprland";
  # };

  services.xserver.updateDbusEnvironment = true;
  # Enable security services
  security.polkit.enable = true;
  security.pam.services = {
    hyprlock = {};
  };

  # this system has a battery
  programs.starship.settings.battery.disabled = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
