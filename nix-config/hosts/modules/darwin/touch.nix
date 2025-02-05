{ inputs
, outputs
, lib
, config
, userConfig
, pkgs
, ...
}: {
  # Add ability to use TouchID for sudo
  security.pam.enableSudoTouchIdAuth = true;
}
