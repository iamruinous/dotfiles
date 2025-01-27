{ pkgs, ... }: {
  # Zed editor configuration
  programs.zed-editor = {
    enable = true;
    userSettings = {
      theme = {
        mode = "dark";
        light = "Tokyo Night";
        dark = "Tokyo Night";
      };
      vim_mode = true;
      ui_font_size = 16;
      buffer_font_size = 18;
    };
    extensions = [
      "tokyo-night"
      "nix"
      "zig"
      "dockerfile"
      "fish"
      "tmux"
      "typos"
      "ruff"
      "lua"
    ];
  };
}
