{lib, ...}: let
  aerospace_config = ../../../files/configs/aerospace/wide;
in {
  xdg.configFile = {
    "aerospace" = {
      source = "${aerospace_config}";
      recursive = true;
    };
  };

  home.activation.aerospace = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo -e "\033[0;34mReloading aerospace config"
    echo -e "\033[0;34m=================="
    /opt/homebrew/bin/aerospace reload-config && echo "Success"
    echo -e "\033[0;34m=================="
  '';
}
## BTT swipe left /usr/local/bin/aerospace workspace "$(/usr/local/bin/aerospace list-workspaces --monitor mouse --visible)" && /usr/local/bin/aerospace workspace next --wrap-around
## BTT swipe right /usr/local/bin/aerospace workspace "$(/usr/local/bin/aerospace list-workspaces --monitor mouse --visible)" && /usr/local/bin/aerospace workspace prev --wrap-around

