{ config, pkgs, lib, unstablePkgs, ... }:
# let
#   nvimDir = "${config.home.homeDirectory}/nix/programs/neovim";
# in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      # Formatters
      pkgs.nixfmt-rfc-style # Nix
      pkgs.black # Python
      pkgs.prettierd # Multi-language
      pkgs.shfmt # Shell
      pkgs.isort # Python
      pkgs.stylua # Lua

      # LSP
      pkgs.lua-language-server
      pkgs.nixd
      pkgs.nil

      # Tools
      pkgs.cmake
      pkgs.fswatch # File watcher utility, replacing libuv.fs_event for neovim 10.0
      pkgs.fzf
      pkgs.gcc
      pkgs.git
      pkgs.gnumake
      pkgs.nodejs
      pkgs.sqlite
      pkgs.tree-sitter
      pkgs.luarocks
    ];
    # plugins = [
    #   pkgs.vimPlugins.lazy-nvim # All other plugins are managed by lazy-nvim
    # ];
  };

  # xdg.configFile = {
  #   # Raw symlink to the plugin manager lock file, so that it stays writeable
  #   "nvim/lazy-lock.json".source = config.lib.file.mkOutOfStoreSymlink "${nvimDir}/lazy-lock.json";
  #   "nvim/neoconf.json".source = config.lib.file.mkOutOfStoreSymlink "${nvimDir}/neoconf.json";
  # };

  # home.file = {
  #   ".config/nvim".source =
  #     pkgs.fetchFromGitHub {
  #       owner = "AstroNvim";
  #       repo = "template";
  #       rev = "20450d8a65a74be39d2c92bc8689b1acccf2cffe";
  #       sha256 = "sha256-P6AC1L5wWybju3+Pkuca3KB4YwKEdG7GVNvAR8w+X1I=";
  #    };
  # };
}
