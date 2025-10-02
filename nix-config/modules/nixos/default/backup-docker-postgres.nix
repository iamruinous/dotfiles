{pkgs, ...}: let
  scripts_dir = ../../../files/scripts;
  postgres_backup_script = "${scripts_dir}/postgres_backup.sh";
in {
  systemd.services.postgres-backup = {
    description = "postgres backup";
    path = with pkgs; [
      coreutils
      docker
      gawk
    ];
    serviceConfig = {
      Type = "oneshot"; # For tasks that run and exit
      ExecStart = "${pkgs.bash}/bin/bash ${postgres_backup_script}";
    };
  };

  systemd.timers.postgres-backup = {
    wantedBy = ["timers.target"]; # Ensures the timer starts with the system
    timerConfig = {
      Unit = "postgres-backup.service"; # Links to the service defined above
      OnCalendar = "*-*-* 01:00:00"; # Example: run daily at midnight
      Persistent = true; # Ensures the timer runs even if the system was off during a scheduled run
    };
  };
}
