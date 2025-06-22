{
  inputs,
  pkgs,
  config,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    # package = pkgs.nixFlakes;
    # package = nixVersions.stable;
    # settings.experimental-features = ["nix-command" "flakes"];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # USB setup
  services.devmon.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  boot.kernelModules = ["fuse"];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      meslo-lg
      nerdfonts
      font-awesome
      fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.fira-code
    ];

    fontconfig = {
      defaultFonts = {
        monospace = ["Meslo"];
      };
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [
    gnome-tweaks
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
  xdg.portal.enable = true;
  # xdg.portal.extraPortals = [
  #   pkgs.xdg-desktop-portal-gtk
  # ];

  hardware.graphics.enable = true;

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # firewall
  networking.firewall.enable = false;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  #trezor
  services.udev.packages = with pkgs; [trezor-udev-rules];
}
