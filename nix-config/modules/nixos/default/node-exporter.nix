{lib, ...}: {
  services.prometheus = {
    exporters = {
      node = {
        enable = lib.mkDefault true;
        enabledCollectors = ["systemd"];
        port = 9002;
      };
    };
  };
}
