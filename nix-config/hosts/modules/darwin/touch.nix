{...}: {
  # Add ability to use TouchID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;
}
