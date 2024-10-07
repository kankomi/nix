{
  pkgs,
  inputs,
  nix,
  services,
  ...
}: {
  # imports = [(import ./waybar)];

  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
      #   inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      # inputs.hyprland-plugins.packages.${pkgs.system}.borders-plus-plus
    ];

    settings = {
      "$mod" = "SUPER";
      "$filemanager" = "nautilus";

      general = {
        border_size = 2;
        gaps_in = 5;
        gaps_out = 10;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        resize_on_border = true;
      };

      input = {
        kb_layout = "de";
        follow_mouse = 1;
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        touchpad = {
          natural_scroll = true;
        };
      };

      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures = {
        workspace_swipe = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bind =
        [
          "$mod, Q, exec, kitty"
          "$mod, F, fullscreen"
          "$mod, SPACE, exec, rofi -show drun"
          "$mod, R, exec, $menu"
          "$mod, E, exec, $filemanager"
          "$mod SHIFT, B, exec, ~/.config/ml4w/scripts/reload-waybar.sh"
          "$mod, W, killactive,"
          "$mod, M, exit,"
          "$mod, V, togglefloating,"
          "$mod, I, togglesplit,"
          "$mod, P, pseudo,"
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"
          "$mod, J, movefocus, d"
          # "$mod, left, move, l"
          # "$mod, right, move, r"
          # "$mod, up, move, u"
          # "$mod, down, move, d"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      exec-once = [
        "dunst"
        "waybar"
        "hyprpaper"
        "nm-applet --indicator"
      ];
    };
  };

  home.packages = [
    pkgs.dunst
    pkgs.libnotify
    pkgs.waybar
    pkgs.kitty
    pkgs.hyprcursor
    pkgs.hyprlang
    pkgs.hyprpaper
    pkgs.hyprlock
    pkgs.rofi-wayland
    pkgs.pavucontrol
    pkgs.font-awesome
    pkgs.fira
    pkgs.fira-sans
    pkgs.blueman
    pkgs.alacritty
    pkgs.networkmanagerapplet
  ];

  programs = {
    kitty.enable = true;
  };
}
