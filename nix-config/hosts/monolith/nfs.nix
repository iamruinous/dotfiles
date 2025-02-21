{...}: {
  fileSystems = {
    "/nas/media" = {
      device = "terranas.manage.farmhouse.meskill.network:/mnt/tank/share/media";
      fsType = "nfs";
      options = ["nfsvers=4.2"];
    };
    "/nas/roms" = {
      device = "terranas.manage.farmhouse.meskill.network:/mnt/tank/share/roms";
      fsType = "nfs";
      options = ["nfsvers=4.2"];
    };
  };
}
