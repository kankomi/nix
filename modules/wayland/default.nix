{pkgs, ...}: {
  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    plugins = with pkgs; [
      dunst
      libnotify
      swww
      kitty
      # rofi
    ];

    settings = {};
  };
  programs = {
    waybar.enable = true;

    eww = {
      enable = true;
      configDir = ./eww-config;
    };
  };
}
