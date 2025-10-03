{lib, ...}: {
  programs.ssh = {
    enable = lib.mkDefault true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    extraConfig = ''
      IgnoreUnknown AddKeysToAgent,UseKeychain
      StrictHostKeyChecking no
      UseKeychain yes
    '';
  };
}
