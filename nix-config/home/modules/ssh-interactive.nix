{pkgs, ...}: let
  identityAgent =
    if (pkgs.stdenv.isDarwin)
    then "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else "~/.1password/agent.sock";
in {
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    extraConfig = ''
      IgnoreUnknown AddKeysToAgent,UseKeychain
      StrictHostKeyChecking no
      UseKeychain yes
      IdentityFile ~/.ssh/id_ed25519
      IdentityFile ~/.ssh/id_jademeskill_ed25519
      IdentityFile ~/.ssh/id_ruinous_computer_ed25519
      IdentityFile ~/.ssh/id_rsa
      IdentityAgent "${identityAgent}"
    '';
  };
}
