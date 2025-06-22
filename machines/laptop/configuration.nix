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

  boot.initrd.kernelModules = ["amdgpu"];

  environment.systemPackages = with pkgs; [
    mesa-demos
    vulkan-tools
    clinfo
    # davinci-resolve-studio
  ];
  programs.hyprland.enable = true;
  services.dbus.enable = true;
  services.xserver.videoDrivers = ["amdgpu"];
  environment.variables = {
    RUSTICL_ENABLE = "radeonsi";
    ROC_ENABLE_PRE_VEGA = "1";
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      mesa
      libva
      libvdpau-va-gl
      vulkan-loader
      vulkan-validation-layers
      amdvlk # Optional: AMD's proprietary Vulkan driver
      mesa.opencl # Enables Rusticl (OpenCL) support
    ];
  };

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
