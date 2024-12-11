{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.vdirsyncer-systemd;
in
{
  options = {
    services.vdirsyncer-systemd = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable vdirsyncer auto-sync.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.timers.vdirsyncer = {
      Unit = {
        Description = "sync vdirsyncer";
      };

      Timer = {
        OnBootSec = "1m";
        OnUnitInactiveSec = "15m";
        Unit = "vdirsyncer.service";
      };

      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
    systemd.user.services.vdirsyncer = {
      Unit = {
        Description = "vdirsyncer auto sync";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.vdirsyncer}/bin/vdirsyncer sync";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
