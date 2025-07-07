{ lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = lib.mkForce 0.8;

      font = {
        builtin_box_drawing = true;
        normal = {
          style = lib.mkForce "Bold";
        };
      };
    };
  };
}
