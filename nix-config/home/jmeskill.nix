{ config, pkgs, lib, unstablePkgs, ... }:
{
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  }; 

  # programs.gpg.enable = true;

  programs.keychain = {
    enable = true;
    inheritType = "any-once";
    extraFlags = [
      "--ignore-missing"
      "--quiet"
    ];
    agents = [
      "ssh"
      # "gpg"
    ];
    keys = [
      "~/.ssh/id_ed25519"
      "~/.ssh/id_jademeskill_ed25519"
      "~/.ssh/id_ruinous_computer_ed25519"
      "~/.ssh/id_rsa"
      # "00AB98E4EDFA6211"
      # "CA5500A8F3A920A0"
    ];
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.fish = {
    enable = true;
    shellAbbrs = {
      dl = "curl --create-dirs -O --output-dir /tmp/";
    };

    functions = {
      fish_user_key_bindings = ''
        bind \t complete-and-search
        bind \cw backward-kill-word

        # Alt+left
        bind \e\[1\;3D backward-kill-bigword
        bind \ek kill-whole-line
      '';

      ls = {
        wraps = "eza";
        body = "eza --git --icons -ga --group-directories-first $argv";
      };

      ll = {
        wraps = "ls";
        body = "ls -lahF $argv";
      };

      l = {
        wraps = "xplr";
        body = "xplr $argv";
      };

      find = {
        wraps = "fd";
        body = "fd --follow --hidden $argv";
      };

      cat = {
        wraps = "bat";
        body = "bat $argv";
      };

      less = {
        wraps = "moar";
        body = "moar $argv";
      };

      top = {
        wraps = "btop";
        body = "btop $argv";
      };

      history = "builtin history --show-time='%h/%d - %H:%M:%S ' | moar";

      tree = {
        wraps = "eza";
        body = "eza --git --icons --tree $argv";
      };

      ps = {
        wraps = "procs";
        body = "procs $argv";
      };

      pkill = "command pkill -f -e $argv";

      df = {
        wraps = "duf";
        body = "duf --hide-fs tmpfs,vfat,devfs,devtmpfs $argv";
      };

      du = {
        wraps = "dust";
        body = "dust -b $argv";
      };

      cal = {
        wraps = "khal";
        body = "khal $argv";
      };

      call = "cal list";
      cala = "cal calendar";
      cali = "ikhal";

      vim = {
        wraps = "nvim";
        body = "nvim $argv";
      };

      vi = "vim";
    };

    plugins = with pkgs.fishPlugins; [
      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }
    ];
  };

  programs.starship = {
    enable = true;
    enableTransience = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
    extraConfig = ''
    StrictHostKeyChecking no
    UseKeychain yes
    IgnoreUnknown UseKeychain
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
      "plex" = {
        hostname = "plex.svc.farmhouse.meskill.network";
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
