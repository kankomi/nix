{
  config,
  pkgs,
  lib,
  user,
  inputs,
  ...
}: {
  imports = [(import ../modules)];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    home-manager

    # Terminal
    htop
    ripgrep
    fzf
    curl
    wget
    tree
    neofetch
    xclip
    stow
    killall
    gparted

    brave
    obsidian
    discord

    vlc

    unzip
    rsync

    # Usb autoload
    udisks2
    # gvfs
    gnome.gvfs
    # gvfs-mtp
    jmtpfs
    libmtp
    mtpfs
    # gvfs-gphoto2
    gphoto2
    gphoto2fs
    libgphoto2

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
    "~/.cargo/bin"
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.
}
