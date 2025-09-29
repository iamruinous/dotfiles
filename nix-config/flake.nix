{
  description = "Blueprint-driven NixOS config and dotfiles";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # Map folder structure to flake outputs
    # <https://github.com/numtide/blueprint>
    blueprint.url = "github:numtide/blueprint";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # NixOS profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";

    # arion for docker
    arion.url = "github:hercules-ci/arion";

    # Nix Darwin (for MacOS machines)
    darwin.url = "github:LnL7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # Fenix for rust
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    # Secureboot
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    lanzaboote.nixpkgs.follows = "nixpkgs";

    # Wezterm
    wezterm.url = "github:wez/wezterm?dir=nix";

    # Hyprland
    hyprshell.url = "github:H3rmt/hyprswitch?ref=hyprshell";
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
    walker.url = "github:abenz1267/walker";

    # Agenix for secrets
    agenix.url = "github:ryantm/agenix";

    # Flatpak
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # Disko
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Plasma Manager
    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    NixVirt.url = "https://flakehub.com/f/AshleyYakeley/NixVirt/*.tar.gz";
    NixVirt.inputs.nixpkgs.follows = "nixpkgs";

    microvm.url = "github:astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";

    # ai coding agents
    # <https://github.com/numtide/nix-ai-tools>
    nix-ai-tools.url = "github:numtide/nix-ai-tools";
  };

  outputs = inputs: {
    # Blueprint automatically maps: devshells, hosts, lib, modules, packages
    inherit
      (inputs.blueprint {inherit inputs;})
      ;

    # Map additional folders to custom outputs
    inherit
      (inputs.self.lib)
      ;

    caches = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
    ];

    # Derive Seeds (BIP-85) > 32-bytes hex > Index Number:
    derivationIndex = 1;
  };

  # outputs = {
  #   self,
  #   darwin,
  #   home-manager,
  #   agenix,
  #   disko,
  #   fenix,
  #   lanzaboote,
  #   nix-flatpak,
  #   nix-homebrew,
  #   NixVirt,
  #   microvm,
  #   nixpkgs,
  #   plasma-manager,
  #   walker,
  #   arion,
  #   ...
  # } @ inputs: let
  #   inherit (self) outputs;
  #
  #   # Define user configurations
  #   users = {
  #     jmeskill = {
  #       #avatar = ./files/avatar/face;
  #       email = "jade.meskill@gmail.com";
  #       fullName = "Jade Meskill";
  #       #gitKey = "C5810093";
  #       name = "jmeskill";
  #     };
  #     kids = {
  #       #avatar = ./files/avatar/face;
  #       #email = "jade.meskill@gmail.com";
  #       fullName = "Meskill Kids";
  #       #gitKey = "C5810093";
  #       name = "kids";
  #     };
  #   };
  #
  #   # Function for NixOS system configuration
  #   mkNixosConfiguration = system: hostname: username:
  #     nixpkgs.lib.nixosSystem {
  #       inherit system;
  #       specialArgs = {
  #         inherit inputs outputs hostname;
  #         userConfig = users.${username};
  #       };
  #       modules = [
  #         {
  #           nixpkgs.overlays = builtins.attrValues outputs.overlays;
  #           nixpkgs.config.allowUnfree = true;
  #         }
  #         ./hosts/${hostname}/configuration.nix
  #         lanzaboote.nixosModules.lanzaboote
  #         agenix.nixosModules.default
  #         {
  #           environment.systemPackages = [agenix.packages.${system}.default];
  #         }
  #         disko.nixosModules.disko
  #         nix-flatpak.nixosModules.nix-flatpak
  #         arion.nixosModules.arion
  #         NixVirt.nixosModules.default
  #         microvm.nixosModules.host
  #       ];
  #     };
  #
  #   # Function for nix-darwin system configuration
  #   mkDarwinConfiguration = system: hostname: username:
  #     darwin.lib.darwinSystem {
  #       inherit system;
  #       specialArgs = {
  #         inherit inputs outputs hostname;
  #         userConfig = users.${username};
  #       };
  #       modules = [
  #         {
  #           nixpkgs.overlays = builtins.attrValues outputs.overlays;
  #           nixpkgs.config.allowUnfree = true;
  #         }
  #         ./hosts/${hostname}/configuration.nix
  #         home-manager.darwinModules.home-manager
  #         nix-homebrew.darwinModules.nix-homebrew
  #         agenix.nixosModules.default
  #         {
  #           environment.systemPackages = [agenix.packages.${system}.default];
  #         }
  #       ];
  #     };
  #
  #   # Function for Home Manager configuration
  #   mkHomeConfiguration = system: hostname: username:
  #     home-manager.lib.homeManagerConfiguration {
  #       pkgs = import nixpkgs {
  #         inherit system;
  #         config.allowUnfree = true;
  #         overlays = builtins.attrValues outputs.overlays;
  #       };
  #       extraSpecialArgs = {
  #         inherit inputs outputs hostname;
  #         userConfig = users.${username};
  #       };
  #       modules = [
  #         ./home/${username}/${hostname}.nix
  #         agenix.homeManagerModules.default
  #         nix-flatpak.homeManagerModules.nix-flatpak
  #         plasma-manager.homeManagerModules.plasma-manager
  #         NixVirt.homeModules.default
  #       ];
  #     };
  # in {
  #   nixosConfigurations = {
  #     "framework" = mkNixosConfiguration "x86_64-linux" "framework" "jmeskill";
  #     "inspo" = mkNixosConfiguration "x86_64-linux" "inspo" "jmeskill";
  #     "jmacnix" = mkNixosConfiguration "x86_64-linux" "jmacnix" "jmeskill";
  #     "kidmacnix" = mkNixosConfiguration "x86_64-linux" "kidmacnix" "kids";
  #     "monolith" = mkNixosConfiguration "x86_64-linux" "monolith" "jmeskill";
  #     "moonstone" = mkNixosConfiguration "x86_64-linux" "moonstone" "jmeskill";
  #     "obelisk" = mkNixosConfiguration "x86_64-linux" "obelisk" "jmeskill";
  #     "tty-ruinous-social" = mkNixosConfiguration "x86_64-linux" "tty-ruinous-social" "jmeskill";
  #   };
  #
  #   darwinConfigurations = {
  #     "jbookair" = mkDarwinConfiguration "aarch64-darwin" "jbookair" "jmeskill";
  #     "jbookpro" = mkDarwinConfiguration "aarch64-darwin" "jbookpro" "jmeskill";
  #     "jmacmini" = mkDarwinConfiguration "aarch64-darwin" "jmacmini" "jmeskill";
  #     "studio" = mkDarwinConfiguration "x86_64-darwin" "studio" "jmeskill";
  #   };
  #
  #   homeConfigurations = {
  #     "jmeskill@framework" = mkHomeConfiguration "x86_64-linux" "framework" "jmeskill";
  #     "jmeskill@inspo" = mkHomeConfiguration "x86_64-linux" "inspo" "jmeskill";
  #     "jmeskill@jbookair" = mkHomeConfiguration "aarch64-darwin" "jbookair" "jmeskill";
  #     "jmeskill@jbookpro" = mkHomeConfiguration "aarch64-darwin" "jbookpro" "jmeskill";
  #     "jmeskill@jmacmini" = mkHomeConfiguration "aarch64-darwin" "jmacmini" "jmeskill";
  #     "jmeskill@jmacnix" = mkHomeConfiguration "x86_64-linux" "jmacnix" "jmeskill";
  #     "jmeskill@monolith" = mkHomeConfiguration "x86_64-linux" "monolith" "jmeskill";
  #     "jmeskill@moonstone" = mkHomeConfiguration "x86_64-linux" "moonstone" "jmeskill";
  #     "jmeskill@obelisk" = mkHomeConfiguration "x86_64-linux" "obelisk" "jmeskill";
  #     "jmeskill@studio" = mkHomeConfiguration "x86_64-darwin" "studio" "jmeskill";
  #     "jmeskill@tty-ruinous-social" = mkHomeConfiguration "x86_64-linux" "tty-ruinous-social" "jmeskill";
  #   };
  #
  #   overlays = import ./overlays {inherit inputs;};
  #   packages = (import "${nixpkgs}/lib").genAttrs ["x86_64-linux" "aarch64-darwin" "x86_64-darwin"] (system: {
  #     nelko-pl70ebt =
  #       (import nixpkgs {
  #         inherit system;
  #         config.allowUnfree = true;
  #         overlays = builtins.attrValues outputs.overlays;
  #       }).nelko-pl70ebt;
  #   });
  # };
}
