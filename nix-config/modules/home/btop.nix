{...}: {
  # Install btop via home-manager module
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "tokyo_night";
      theme_background = false;
      vim_keys = true;
    };
  };
}
