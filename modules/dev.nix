{
  config,
  pkgs,
  user,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    lazygit
    # rnix-lsp
    nixpkgs-fmt
  ];

  virtualisation.docker.enable = true;
  users.users.${user}.extraGroups = [ "docker" ];
}
