{config, ...}: {
  # Enable restic backups
  services.restic.backups = {
    terranasbackup = {
      paths = ["/home" "/etc"];
      repository = "sftp:tmbackup@terranas.manage.farmhouse.meskill.network:/mnt/tank/tmbackup/linux-backup/obelisk";
      passwordFile = config.age.secrets.restic_password.path;
      timerConfig = {
        OnCalendar = "00:05";
        RandomizedDelaySec = "5h";
      };
    };
  };

  age.secrets.restic_password = {
    file = ../../../files/configs/restic/restic-password.age;
    mode = "600";
  };
}
