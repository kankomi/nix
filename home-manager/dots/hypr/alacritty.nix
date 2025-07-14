{ lib, ... }:
{
  programs.alacritty = {
    enable = true;
    theme = "catppuccin_mocha";
    settings = {
      window.opacity = lib.mkForce 0.8;
      window.dynamic_padding = lib.mkForce true;
      window.padding = lib.mkForce {
        x = 10;
        y = 10;
      };
      env = {
        TERM = "xterm-256color";
      };

      font = {
        size = lib.mkForce 14;
        builtin_box_drawing = true;
        normal = {
          family = lib.mkForce "CaskaydiaCove Nerd Font";
          # style = lib.mkForce "Bold";
        };
        bold_italic = {
          family = lib.mkForce "CaskaydiaCove Nerd Font";
          style = lib.mkForce "Bold Italic";
        };
        italic = {
          family = lib.mkForce "CaskaydiaCove Nerd Font";
          style = lib.mkForce "Italic";
        };
      };
    };
  };
}
