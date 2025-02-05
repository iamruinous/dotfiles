{ userConfig, ... }:
let
  git_config = ../../files/configs/git;
in
{
  # home.file.".ssh/allowed_signers".text = ''
  #   iamruinous@ruinous.social ${builtins.readFile ~/.ssh/id_ed25519.pub}
  #   iamruinous@ruinous.social ${builtins.readFile ~/.ssh/id_ruinous_computer_ed25519.pub}
  #   jade.meskill@gmail.com ${builtins.readFile ~/.ssh/id_jademeskill_ed25519.pub}
  # '';
  # Install git via home-manager module
  programs.git = {
    enable = true;
    lfs.enable = true;
    aliases = {
      a = "add";
      c = "commit -v";
      co = "checkout";
      d = "diff";
      ds = "diff --staged";
      s = "status";
      crypt = "git-crypt";
    };
    signing = {
      key = "iamruinous@ruinous.social";
      signByDefault = true;
    };
    includes = [
      {
        path = "~/.config/git/includes/github.inc";
        condition = "gitdir/i:github\\/iamruinous/";
      }
    ];
    extraConfig = {
      tag.forceSignAnnotated = "true";
      pull.rebase = "false";
      fetch.prune = "true";
      push.default = "tracking";
      merge.tool = "vim";
      difftool.prompt = "false";
      mergetool.prompt = "false";
      status.submoduleSummary = "true";
      diff.submodule = "log";
      branch.autosetupmerge = "true";
      init.defaultBranch = "main";
    };
  };

  xdg.configFile = {
    "git" = {
      source = "${git_config}";
      recursive = true;
    };
  };
}
