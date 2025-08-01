{ pkgs, ... }:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Dynamic libraries for unpackaged programs
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    glibc
    libcxx
  ];

  nix = {
    # package = pkgs.nixFlakes;
    # package = nixVersions.stable;
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

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      meslo-lg
      # nerdfonts
      font-awesome
      fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.caskaydia-cove
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "Meslo" ];
      };
    };
  };

  # Configure console keymap
  console.keyMap = "de";

  # firewall
  networking.firewall.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
