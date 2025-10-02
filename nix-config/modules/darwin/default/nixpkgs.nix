{...}: {
  # Accept agreements for unfree software
  nixpkgs.config = {
    allowUnfree = true;
  };
}
