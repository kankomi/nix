{ config
, pkgs
, ...
}: {
  programs.git = {
    enable = true;
    userName = "Patrick Gross";
    userEmail = "patrick@pgross.de";
    aliases = {
      a = "add";
      ci = "commit";
      co = "checkout";
      st = "status";
    };
    extraConfig = {
      init = { defaultBranch = "main"; };
      pull = { rebase = true; };
      push = { autoSetupRemote = true; };
      core = { whitespace = "trailing-space,space-before-tab"; };
    };
  };
}
