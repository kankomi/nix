{pkgs, ...}: {
  imports = [
    ./base.nix
  ];

  home.packages = with pkgs; [
    brave
    obsidian
    discord

    vlc

    # pkgs.davinci-resolve-studio

    unzip
    rsync

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
  ];
}
