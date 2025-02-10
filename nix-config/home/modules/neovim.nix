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
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraPackages = with pkgs; [
      # Language server packages (executables)
      basedpyright
      lua-language-server
      nil
      stylua
      selene
    ];
  };

  xdg.configFile = {
    "nvim" = {
      source = "${nvim_config}";
      recursive = true;
    };
  };
}
