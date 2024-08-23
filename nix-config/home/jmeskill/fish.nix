{ config, pkgs, lib, unstablePkgs, ... }:
{
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
}
