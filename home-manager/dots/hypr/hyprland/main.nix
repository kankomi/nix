{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # WM stuff
    libsForQt5.xwaylandvideobridge
    libnotify
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    hyprpicker
    grimblast
    networkmanagerapplet
    wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      env = [
        # Hint Electron apps to use Wayland
        "NIXOS_OZONE_WL,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,$HOME/screens"
      ];

      monitor = ",1920x1080@60,auto,1";
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "nautilus";
      "$menu" = "wofi";

      exec-once = [
        "waybar"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "blueman-applet"
        "nextcloud"
        "nm-applet &"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 5;

        border_size = 2;

        "col.active_border" = "rgba(d65d0eff) rgba(98971aff) 45deg";
        "col.inactive_border" = "rgba(3c3836ff)";

        resize_on_border = true;

        allow_tearing = false;
        layout = "master";
      };

      decoration = {
        rounding = 15;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = false;
        };

        blur = {
          enabled = true;
          ignore_opacity = true;
          size = 8;
          passes = 4;
          popups = true;
        };
      };

      animations = {
        enabled = true;
        animation = [
          "windows, 1, 2, default, popin 80%"
          "workspaces, 1, 2, default"
        ];
      };

      input = {
        kb_layout = "de";
        kb_options = "caps:swapescape";
        touchpad = {
          natural_scroll = true;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_invert = true;
        workspace_swipe_forever = false;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "slave";
        new_on_top = true;
        mfact = 0.5;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      layerrule = [
        "ignorealpha 0.2,waybar"
        "ignorealpha 0.2,wofi"
        "blur, waybar"
      ];

      windowrulev2 = [
        "bordersize 0, floating:0, onworkspace:w[t1]"

        # "float,class:(mpv)|(imv)|(showmethekey-gtk)"
        # "move 990 60,size 900 170,pin,noinitialfocus,class:(showmethekey-gtk)"
        # "noborder,nofocus,class:(showmethekey-gtk)"
        "float,class:^(.blueman-manager-wrapped)$"
        # "float,title:Nextcloud"
        "noborder,nofocus,class:(wofi)"

        # "workspace 3,class:(obsidian)"

        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      # workspace = [
      #   "w[tv1], gapsout:0, gapsin:0"
      #   "f[1], gapsout:0, gapsin:0"
      # ];
    };
  };
}
