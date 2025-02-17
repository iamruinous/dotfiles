{config, ...}: {
  # Enable restic backups
  services.restic.backups = {
    terranasbackup = {
      paths = [
        "/home"
        "/etc"
      ];
      exclude = [
        "/home/*/.cache"
        "/home/*/.cargo"
        "/home/*/.config"
        "/home/*/.local"
        "/home/*/.mozilla"
        "/home/*/.paradoxlauncher"
        "/home/*/.var"
        "/home/*/Downloads"
      ];
      repository = "sftp:tmbackup@terranas.manage.farmhouse.meskill.network:/mnt/tank/tmbackup/linux-backup/${config.networking.hostName}";
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
