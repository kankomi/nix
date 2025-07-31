{
  pkgs,
  ...
}:
{
  nix.settings.trusted-users = [ "gpa9bh" ];

  users = {
    users = {
      gpa9bh = {
        shell = pkgs.zsh;
        uid = 1000;
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "users"
          "networkmanager"
          "storage"
        ];
        group = "gpa9bh";
      };
    };
    groups = {
      gpa9bh = {
        gid = 1000;
      };
    };
  };
  programs.zsh.enable = true;
}
