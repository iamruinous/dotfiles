{
  description = "Darwin configuration for jbookair";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, home-manager, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs;
        [ 
          vim
        ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      nix.package = pkgs.nixVersions.latest;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      fonts.packages = with pkgs; [
        fira-code
        fira-code-nerdfont
        fira-mono
        monaspace
      ];

      homebrew = {
        enable = true;

        casks = [
          "1password-cli"
          "dropbox"
          "font-bigblue-terminal-nerd-font"
          "font-fira-code-nerd-font"
          "mimestream"
          "todoist"
        ];

        masApps = {
        };
      };

      system.defaults = {
        # minimal dock
        dock = {
          autohide = true;
          magnification = true;
          largesize = 96;
          orientation = "bottom";
          static-only = false;
          show-process-indicators = true;
          show-recents = true;
        };
        # a finder that tells me what I want to know and lets me work
        finder = {
          AppleShowAllExtensions = true;
          ShowPathbar = true;
          FXEnableExtensionChangeWarning = false;
        };
        # Tab between form controls and F-row that behaves as F1-F12
        NSGlobalDomain = {
          AppleKeyboardUIMode = 3;
          "com.apple.keyboard.fnState" = true;
        };
      };

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };

    homeconfig = { pkgs, ... }: {
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;

      home.packages = with pkgs; [
        # config management
        age
        chezmoi

        # utils
        btop
        cargo-binstall
        duf
        dust
        eza
        khal
        fd
        fzf
        gnupg
        htop
        keychain
        mas
        moar
        mosh
        procs
        tmux
        xplr
        xz

        # dev tools
        jq
        just
        neovim
        git
        git-secrets


        # languages
        go
        nodejs
        pipx
        python3
        rye
        zig

        # window manager
        jankyborders
        skhd
        yabai

        # prompt stuff
        figlet
        fortune
        lolcat
        neofetch
        starship
        toilet
      ];

      home.sessionVariables = {
        EDITOR = "nvim";
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
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#jbookair
    darwinConfigurations.jbookair = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        {
          users.users.jmeskill.home = "/Users/jmeskill";
        }
        home-manager.darwinModules.home-manager  {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.verbose = true;
          home-manager.users.jmeskill = homeconfig;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."jbookair".pkgs;
  };
}
