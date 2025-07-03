{
  pkgs,
  config,
  ...
}:
let
  username = config.home.username;
in
{
  # Install the credential helper
  home.packages = [
    pkgs.git-credential-manager
  ];

  programs.gh = {
    enable = true;
    settings = {
      version = "1";
      aliases = {
        "as" = "auth status";
        "al" = "auth login";
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Patrick Gross";
    userEmail = if username == "gpa9bh" then "patrick.gross@de.bosch.com" else "patrick@pgross.de";
    aliases = {
      a = "add";
      ci = "commit";
      co = "checkout";
      st = "status";
    };
    package = pkgs.gitFull; # or pkgs.git with pkgs.git-credential-libsecret if desired
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      push = {
        autoSetupRemote = true;
      };
      core = {
        whitespace = "trailing-space,space-before-tab";
      };
      credential.helper = "libsecret";
    };
  };
}
