{ config, pkgs, inputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../config/base.nix
      ../../config/users.nix
      ../../modules/dev.nix
    ];


  networking.hostName = "laptop"; # Define your hostname.
  hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
