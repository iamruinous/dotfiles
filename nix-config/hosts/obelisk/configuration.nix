# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{...}: {
  imports = [
    ./hardware-configuration.nix
    ../modules/common.nix
    ../modules/developer.nix
    ../modules/nixos/desktop-common.nix
    ../modules/nixos/docker.nix
    ../modules/nixos/flatpak.nix
    ../modules/nixos/hyprland.nix
    ../modules/nixos/latest-kernel.nix
    ../modules/nixos/libvirt.nix
    ../modules/nixos/restic.nix
    ../modules/nixos/steam.nix
    ./containers.nix
    ./nfs.nix
    ./vm.nix
  ];

  networking.hostName = "obelisk"; # Define your hostname.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
