# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstablePkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../common/common-packages.nix
    ];

  networking.hostName = "nixai"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  #networking.networkmanager.enable = true;

  # Select internationalisation properties.
  #i18n.defaultLocale = "en_US.UTF-8";

#   i18n.extraLocaleSettings = {
#    LC_ADDRESS = "en_US.UTF-8";
#    LC_IDENTIFICATION = "en_US.UTF-8";
#    LC_MEASUREMENT = "en_US.UTF-8";
#    LC_MONETARY = "en_US.UTF-8";
#    LC_NAME = "en_US.UTF-8";
#    LC_NUMERIC = "en_US.UTF-8";
#    LC_PAPER = "en_US.UTF-8";
#    LC_TELEPHONE = "en_US.UTF-8";
#    LC_TIME = "en_US.UTF-8";
#  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jmeskill = {
    isNormalUser = true;
    description = "Jade Meskill";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  documentation.man.generateCaches = false;

  services.qemuGuest.enable = true;
  services.tailscale.enable = true;
}
