{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../config/base.nix
    ../../users/grop
    ../_common
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.extraModprobeConfig = ''
    options iwlwifi 11n_disable=8
  '';

  hardware.enableRedistributableFirmware = true;
  hardware.firmware = with pkgs; [
    linux-firmware
  ];

  environment.systemPackages = with pkgs; [
    mesa-demos
    vulkan-tools
    clinfo
  ];

  services.dbus.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.desktopManager.gnome.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
  xdg.portal.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # USB setup
  services.devmon.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  boot.kernelModules = [ "fuse" ];

  # setup hibernation
  boot.kernelParams = [
    "resume_offset=74946560"
    "mem_sleep_default=deep"
  ];
  boot.resumeDevice = "/dev/disk/by-uuid/2c8ff523-523b-40d8-ab8c-418eea6cfae9";
  powerManagement.enable = true;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16GB in MB
    }
  ];
  services.power-profiles-daemon.enable = true;
  # Suspend first then hibernate when closing the lid
  services.logind.lidSwitch = "suspend-then-hibernate";
  # Hibernate on power button pressed
  services.logind.powerKey = "hibernate";
  services.logind.powerKeyLongPress = "poweroff";

  # Define time delay for hibernation
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
    SuspendState=mem
  '';

  networking.hostName = "laptop"; # Define your hostname.
  networking.networkmanager = {
    enable = true;
    wifi = {
      powersave = false;
      macAddress = "preserve";
    };
    settings = {
      main = {
        "no-auto-default" = "*";
      };

      connectivity.enabled = "false";

      connection = {
        "ipv6.method" = "ignore";
        "connection.llmnr" = "2";
        "connection.mdns" = "2";
        "wifi.powersave" = "2";
      };
    };
  };

  # Enable printing support.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.printing.drivers = [ pkgs.hplipWithPlugin ];

  hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.tailscale.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  system.stateVersion = "24.05"; # Did you read the comment?
}
