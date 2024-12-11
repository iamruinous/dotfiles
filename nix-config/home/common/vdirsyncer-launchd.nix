{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.vdirsyncer-launchd;
in
{
  options = {
    services.vdirsyncer-launchd = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable vdirsyncer auto-sync.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    launchd.agents.vdirsyncer = {
      enable = true;
      config = {
        ProgramArguments = [ "$[pkgs.vdirsyncer}/bin/vdirsyncer" "sync" ];
        StartInterval = 900;
      };
    };
  };
}
