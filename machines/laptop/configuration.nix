{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../config/base.nix
    ../../config/users.nix
  ];

  # Hyprland
  # programs.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  # };
  # nixpkgs.overlays = [
  #   (self: super: {
  #     waybar = super.waybar.overrideAttrs (oldAttrs: {
  #       mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
  #     });
  #   })
  # ];

  services.displayManager.gdm.wayland = true;

  networking.hostName = "laptop"; # Define your hostname.
  hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  system.stateVersion = "24.05"; # Did you read the comment?
}
