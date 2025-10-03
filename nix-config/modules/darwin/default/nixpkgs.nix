{...}: {
  # Accept agreements for unfree software
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true; # TODO: zig
  };
}
