{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.todoist-auto;
in
{
  options = {
    services.todoist-auto = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable todoist auto-sync.
        '';
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf pkgs.stdenv.isLinux {
      systemd.user.timers.todoist = {
        Unit = {
          Description = "sync todoist";
        };

        Timer = {
          OnBootSec = "1m";
          OnUnitInactiveSec = "15m";
          Unit = "todoist.service";
        };

        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
      systemd.user.services.todoist = {
        Unit = {
          Description = "todoist auto sync";
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.todoist}/bin/todoist sync";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    })
    (mkIf pkgs.stdenv.isDarwin {
      launchd.agents.todoist = {
        enable = true;
        config = {
          ProgramArguments = [ "$[pkgs.todoist}/bin/todoist" "sync" ];
          StartInterval = 900;
        };
      };
    })
  ]);
}

