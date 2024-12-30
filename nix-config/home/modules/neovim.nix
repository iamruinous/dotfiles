{ pkgs, ... }:
let
  nvim_config = ../../files/configs/nvim;
in
{
  # Neovim text editor configuration
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };

  xdg.configFile = {
    "nvim" = {
      source = "${nvim_config}";
      recursive = true;
    };
  };
}
