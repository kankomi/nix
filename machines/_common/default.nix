{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./secrets
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  environment.systemPackages = with pkgs; [
    curl
    wget
    rsync
    inputs.agenix.packages.x86_64-linux.default
    neofetch
    unzip
    htop
  ];

  programs.git.enable = true;

  security = {
    doas.enable = lib.mkDefault false;
    sudo = {
      enable = lib.mkDefault true;
      wheelNeedsPassword = lib.mkDefault false;
    };
  };

  users.users.grop.hashedPasswordFile = config.age.secrets.userHashedPassword.path;
  users.users.root.hashedPasswordFile = config.age.secrets.userHashedPassword.path;
}
