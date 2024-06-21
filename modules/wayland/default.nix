{
  pkgs,
  inputs,
  ...
}: {
  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      inputs.hyprland-plugins.packages.${pkgs.system}.borders-plus-plus
    ];

    settings = {
      "$mod" = "SUPER";

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      "plugin:borders-plus-plus" = {
        add_borders = 1;
        "col.border_1" = "rgb(ffffff)";
        "col.border_2" = "rgb(2222ff)";

        border_size_1 = 10;
        border_size_2 = -1;

        natural_rounding = "yes";
      };
      decoration = {
        shadow_offset = "0 5";
        "col.shadow" = "rgba(00000099)";
      };

      exec-once = [
        "dunst"
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
    {
      url = "github:hyprwm/hyprcursor";
    }
  ];

  programs = {
    waybar.enable = true;
    kitty.enable = true;

    # eww = {
    #   enable = true;
    #   configDir = ./eww-config;
    # };
  };
}
