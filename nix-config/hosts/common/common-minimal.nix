{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    # utils
    git
    rsync
    vim
  ];
}
