{ lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = lib.mkForce 0.8;

      # padding = {
      #   x = lib.mkForce 5;
      #   y = lib.mkForce 5;
      # };
      window.dynamic_padding = lib.mkForce true;

      font = {
        builtin_box_drawing = true;
        normal = {
          family = lib.mkForce "CaskaydiaCove Nerd Font";
          style = lib.mkForce "Bold";
        };
      };
    };
  };
}
