{
  description = "NixOS and nix-darwin configs for my machines";
  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org?priority=10"
      "https://nix-community.cachix.org"
      "https://wezterm.cachix.org"
      "https://walker.cachix.org"
      "https://walker-git.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
    ];
    extra-trusted-users = [
      "root"
      "jmeskill"
      "@wheel"
    ];
  };
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs?rev=d2faa1bbca1b1e4962ce7373c5b0879e5b12cef2";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";

    # Nix Darwin (for MacOS machines)
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # Fenix for rust
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secureboot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Wezterm
    wezterm.url = "github:wez/wezterm?dir=nix";

    # Hyprland
    hyprswitch.url = "github:h3rmt/hyprswitch/release";
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
    walker.url = "github:abenz1267/walker";

    # Agenix for secrets
    agenix.url = "github:ryantm/agenix";

    # Flatpak
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # Disko
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Plasma Manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    NixVirt = {
      url = "https://flakehub.com/f/AshleyYakeley/NixVirt/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    darwin,
    home-manager,
    agenix,
    disko,
    fenix,
    lanzaboote,
    nix-flatpak,
    nix-homebrew,
    NixVirt,
    nixpkgs,
    plasma-manager,
    walker,
    arion,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Define user configurations
    users = {
      jmeskill = {
        #avatar = ./files/avatar/face;
        email = "jade.meskill@gmail.com";
        fullName = "Jade Meskill";
        #gitKey = "C5810093";
        name = "jmeskill";
      };
    };

    # Function for NixOS system configuration
    mkNixosConfiguration = system: hostname: username:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
        };
        modules = [
          ./hosts/${hostname}/configuration.nix
          lanzaboote.nixosModules.lanzaboote
          agenix.nixosModules.default
          {
            environment.systemPackages = [agenix.packages.${system}.default];
          }
          disko.nixosModules.disko
          nix-flatpak.nixosModules.nix-flatpak
          arion.nixosModules.arion
          NixVirt.nixosModules.default
        ];
      };

    # Function for nix-darwin system configuration
    mkDarwinConfiguration = system: hostname: username:
      darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
        };
        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          agenix.nixosModules.default
          {
            environment.systemPackages = [agenix.packages.${system}.default];
          }
        ];
      };

    # Function for Home Manager configuration
    mkHomeConfiguration = system: hostname: username:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {inherit system;};
        extraSpecialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
        };
        modules = [
          ./home/${username}/${hostname}.nix
          agenix.homeManagerModules.default
          nix-flatpak.homeManagerModules.nix-flatpak
          plasma-manager.homeManagerModules.plasma-manager
          NixVirt.homeModules.default
        ];
      };
  in {
    nixosConfigurations = {
      "framework" = mkNixosConfiguration "x86_64-linux" "framework" "jmeskill";
      "inspo" = mkNixosConfiguration "x86_64-linux" "inspo" "jmeskill";
      "jmacnix" = mkNixosConfiguration "x86_64-linux" "jmacnix" "jmeskill";
      "monolith" = mkNixosConfiguration "x86_64-linux" "monolith" "jmeskill";
      "moonstone" = mkNixosConfiguration "x86_64-linux" "moonstone" "jmeskill";
      "obelisk" = mkNixosConfiguration "x86_64-linux" "obelisk" "jmeskill";
    };

    darwinConfigurations = {
      "jbookair" = mkDarwinConfiguration "aarch64-darwin" "jbookair" "jmeskill";
      "jmacmini" = mkDarwinConfiguration "aarch64-darwin" "jmacmini" "jmeskill";
      "studio" = mkDarwinConfiguration "x86_64-darwin" "studio" "jmeskill";
    };

    homeConfigurations = {
      "jmeskill@framework" = mkHomeConfiguration "x86_64-linux" "framework" "jmeskill";
      "jmeskill@inspo" = mkHomeConfiguration "x86_64-linux" "inspo" "jmeskill";
      "jmeskill@jbookair" = mkHomeConfiguration "aarch64-darwin" "jbookair" "jmeskill";
      "jmeskill@jmacmini" = mkHomeConfiguration "aarch64-darwin" "jmacmini" "jmeskill";
      "jmeskill@jmacnix" = mkHomeConfiguration "x86_64-linux" "jmacnix" "jmeskill";
      "jmeskill@monolith" = mkHomeConfiguration "x86_64-linux" "monolith" "jmeskill";
      "jmeskill@moonstone" = mkHomeConfiguration "x86_64-linux" "moonstone" "jmeskill";
      "jmeskill@obelisk" = mkHomeConfiguration "x86_64-linux" "obelisk" "jmeskill";
      "jmeskill@studio" = mkHomeConfiguration "x86_64-darwin" "studio" "jmeskill";
    };

    overlays = import ./overlays {inherit inputs;};
  };
}
