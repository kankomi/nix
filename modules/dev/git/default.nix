{ config
, pkgs
, ...
}: {
  programs.git = {
    enable = true;
    userName = "Patrick Gross";
    userEmail = "patrick@pgross.de";
    extraConfig = {
      init = { defaultBranch = "main"; };
      pull = { rebase = true; };
      push = { autoSetupRemote = true; };
      core = { whitespace = "trailing-space,space-before-tab"; };
    };
  };
}
