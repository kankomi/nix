{ pkgs, ... }:
{
  imports = [
    ../dots/dev
    ../dots/zsh
    ../dots/btop
    ../dots/nixvim
    ../dots/apps/usb
    ../dots/gnome
    ../dots/hypr
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "grop";
  home.homeDirectory = "/home/grop";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    home-manager

    # Terminal
    ripgrep
    fzf
    xclip
    powertop
    jq

    brave
    obsidian
    discord
    nextcloud-client
    spotify

    vlc

    # pkgs.davinci-resolve-studio

    # Usb autoload
    udisks2
    gnome.gvfs
    jmtpfs
    libmtp
    mtpfs
    gphoto2
    gphoto2fs
    libgphoto2
    darktable

    # Dev
    lazygit
    go
    gnumake
    nodejs_22
    gcc
    rustc
    rustup

    #go
    templ
    air

    #wine
    wineWowPackages.stable
    winetricks

    # tailscale
    tailscale
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.sessionPath = [
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.
}
