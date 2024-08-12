{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";

    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # disko.url = "github:nix-community/disko";
    # disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, home-manager, nix-darwin, nixpkgs, nixpkgs-unstable, nixpkgs-darwin }:
  let
    inputs = { inherit home-manager nixpkgs nixpkgs-unstable nix-darwin; };

    genPkgs = system: import nixpkgs { inherit system; config.allowUnfree = true; };
    genUnstablePkgs = system: import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
    genDarwinPkgs = system: import nixpkgs-darwin { inherit system; config.allowUnfree = true; };

    # creates a nixos system config
    nixosSystem = system: hostname: username:
      let
        pkgs = genPkgs system;
        unstablePkgs = genUnstablePkgs system;
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit pkgs unstablePkgs;
            # lets us use these things in modules
            customArgs = { inherit system hostname username pkgs unstablePkgs; };
          };
          modules = [
            #disko.nixosModules.disko
            #./hosts/nixos/${hostname}/disko-config.nix

            ./hosts/nixos/${hostname}

            home-manager.nixosModules.home-manager {
              networking.hostName = hostname;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = { imports = [ ./home/${username}.nix ]; };
            }
            ./hosts/common/nixos-common.nix
          ];
        };

    # creates a macos system config
    darwinSystem = system: hostname: username:
      let
        pkgs = genDarwinPkgs system;
      in
        nix-darwin.lib.darwinSystem {
          inherit system inputs;
          specialArgs = {
            # adds unstable to be available in top-level evals (like in common-packages)
            unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${system};

            # lets us use these things in modules
            customArgs = { inherit system hostname username pkgs; };
          };
          modules = [
            ./hosts/darwin/${hostname} # ip address, host specific stuff
            home-manager.darwinModules.home-manager {
              networking.hostName = hostname;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = { imports = [ ./home/${username}.nix ]; };
            }
            ./hosts/common/darwin-common.nix
          ];
        };
  in {
    darwinConfigurations = {
      jbookair = darwinSystem "aarch64-darwin" "jbookair" "jmeskill";
      jmacmini = darwinSystem "aarch64-darwin" "jmacmini" "jmeskill";
      studio = darwinSystem "x86_64-darwin" "studio" "jmeskill";
    };

    nixosConfigurations = {
      # use this for a blank ISO + disko to work
      nixos = nixosSystem "x86_64-linux" "nixos" "jmeskill";
    };
  };
}
