# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: let
  scripts_dir = ./files/scripts;
  pgbackup_script = "${scripts_dir}/pg_backup.sh";
in {
  imports = [
    ./hardware-configuration.nix
    ../modules/common.nix
    ../modules/developer.nix
    ../modules/nixos/common.nix
    ../modules/nixos/docker.nix
    ../modules/nixos/latest-kernel.nix
    ../modules/nixos/restic.nix
    ../modules/nixos/sudoless.nix
    ../modules/nixos/tailscale.nix
    # ./caddy.nix
    ./containers.nix
    ./disko.nix
    ./nfs.nix
    ./rtl_433.nix
  ];

  networking.hostName = "monolith"; # Define your hostname.

  services.tailscale.useRoutingFeatures = "server";

  virtualisation.docker.storageDriver = "btrfs";

  programs.nix-ld.enable = true;

  systemd.services.pgbackup = {
    description = "pg_dump all dbs";
    serviceConfig = {
      Type = "oneshot"; # For tasks that run and exit
      ExecStart = "${pkgs.bash}/bin/bash ${pgbackup_script}";
    };
  };

  systemd.timers.pgbackup = {
    wantedBy = ["timers.target"]; # Ensures the timer starts with the system
    timerConfig = {
      Unit = "pgbackup.service"; # Links to the service defined above
      OnCalendar = "*-*-* 00:00:00"; # Example: run daily at midnight
      Persistent = true; # Ensures the timer runs even if the system was off during a scheduled run
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
