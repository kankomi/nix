{
  config,
  pkgs,
  ...
}: {
  # Install the credential helper
  home.packages = [
    pkgs.git-credential-manager
  ];

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
    package = pkgs.gitFull; # or pkgs.git with pkgs.git-credential-libsecret if desired
    extraConfig = {
      init = {defaultBranch = "main";};
      pull = {rebase = true;};
      push = {autoSetupRemote = true;};
      core = {whitespace = "trailing-space,space-before-tab";};
      credential.helper = "libsecret";
    };
  };
}
