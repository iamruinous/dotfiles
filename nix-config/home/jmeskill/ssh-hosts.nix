{ config, pkgs, lib, unstablePkgs, ... }:
{

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
    extraConfig = ''
    IgnoreUnknown AddKeysToAgent,UseKeychain
    StrictHostKeyChecking no
    UseKeychain yes
    IdentityFile ~/.ssh/id_ed25519
    IdentityFile ~/.ssh/id_jademeskill_ed25519
    IdentityFile ~/.ssh/id_ruinous_computer_ed25519
    IdentityFile ~/.ssh/id_rsa
    '';
    matchBlocks = {
      "*.meskill.network 10.55.*" = {
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };

      # svc
      "ai" = {
        hostname = "ai.svc.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "crew" = {
        hostname = "crew.svc.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "deluger" = {
        hostname = "deluger.svc.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "etv" = {
        hostname = "etv.svc.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "frigate" = {
        hostname = "frigate.svc.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "getterr" = {
        hostname = "getterr.svc.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "jellyfin" = {
        hostname = "jellyfin.svc.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "kodi" = {
        hostname = "kodi.svc.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "plex" = {
        hostname = "plex.svc.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "remote" = {
        hostname = "remote.svc.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "tip" = {
        hostname = "tip.svc.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "touchstone" = {
        hostname = "touchstone.svc.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };

      # manage
      "freenas" = {
        hostname = "freenas.manage.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "graf" = {
        hostname = "graf.manage.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "it" = {
        hostname = "it.manage.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "moonstone" = {
        hostname = "moonstone.manage.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "nut" = {
        hostname = "nut.manage.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "obelisk" = {
        hostname = "obelisk.manage.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "obsidian" = {
        hostname = "obsidian.manage.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "onyx" = {
        hostname = "onyx.manage.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "pbs" = {
        hostname = "pbs.manage.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "pit" = {
        hostname = "pit.manage.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "spinel" = {
        hostname = "spinel.manage.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "truenas" = {
        hostname = "truenas.manage.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };

      # rsync 
      "de1381b.rsync.net rsync.net" = {
        hostname = "de1381b.rsync.net";
        user = "root";
      };

      # ruinous computers
      "mail.ruinous.social" = {
        hostname = "mail.ruinous.social";
        user = "iamruinous";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };

      "ruinous.computer tty.ruinous.computer" = {
        hostname = "tty.ruinous.computer";
        user = "iamruinous";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };

      "ruinous.social tty.ruinous.social" = {
        hostname = "tty.ruinous.social";
        user = "iamruinous";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };


      # tailscale
      "*.greyhound-triceratops.ts.net 100.*" = {
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-ai" = {
        hostname = "ai.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-crew" = {
        hostname = "crew.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-deluger" = {
        hostname = "deluger.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-etv" = {
        hostname = "etv.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-getterr" = {
        hostname = "getterr.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-jellyfin" = {
        hostname = "jellyfin.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-moonstone" = {
        hostname = "moonstone.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-obelisk" = {
        hostname = "obelisk.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-obsidian" = {
        hostname = "obsidian.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-onyx" = {
        hostname = "onyx.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-plex" = {
        hostname = "plex.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-remote" = {
        hostname = "remote.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-touchstone" = {
        hostname = "touchstone.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };

    };
  };
}