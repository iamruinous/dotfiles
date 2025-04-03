{...}: {
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    extraConfig = ''
      IgnoreUnknown AddKeysToAgent,UseKeychain
      StrictHostKeyChecking no
      UseKeychain yes
    '';
  };
}
