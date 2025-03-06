{...}: {
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
      IdentityAgent ~/.1password/agent.sock
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
      "mono" = {
        hostname = "mono.svc.farmhouse.meskill.network";
        user = "jmeskill";
        forwardAgent = true;
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

      # manage
      "it" = {
        hostname = "it.manage.farmhouse.meskill.network";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "monolith" = {
        hostname = "monolith.manage.farmhouse.meskill.network";
        user = "jmeskill";
        forwardAgent = true;
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "moonstone" = {
        hostname = "moonstone.manage.farmhouse.meskill.network";
        user = "jmeskill";
        forwardAgent = true;
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
        user = "jmeskill";
        forwardAgent = true;
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
      "terranas" = {
        hostname = "terranas.manage.farmhouse.meskill.network";
        user = "admin";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "truenas" = {
        hostname = "truenas.manage.farmhouse.meskill.network";
        user = "admin";
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
        forwardAgent = true;
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };

      "ruinous.computer tty.ruinous.computer" = {
        hostname = "tty.ruinous.computer";
        user = "iamruinous";
        forwardAgent = true;
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };

      "ruinous.social tty.ruinous.social" = {
        hostname = "tty.ruinous.social";
        user = "iamruinous";
        forwardAgent = true;
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
      "ts-monolith" = {
        hostname = "monolith.greyhound-triceratops.ts.net";
        user = "jmeskill";
        forwardAgent = true;
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-moonstone" = {
        hostname = "moonstone.greyhound-triceratops.ts.net";
        user = "jmeskill";
        forwardAgent = true;
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-nut" = {
        hostname = "nut.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-obelisk" = {
        hostname = "obelisk.greyhound-triceratops.ts.net";
        user = "jmeskill";
        forwardAgent = true;
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
      "ts-pit" = {
        hostname = "pit.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-terranas" = {
        hostname = "terranas.greyhound-triceratops.ts.net";
        user = "admin";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-tip" = {
        hostname = "tip.greyhound-triceratops.ts.net";
        user = "admin";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
      "ts-truenas" = {
        hostname = "truenas.greyhound-triceratops.ts.net";
        user = "root";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new-session -A -s shell";
        };
      };
    };
  };
}
