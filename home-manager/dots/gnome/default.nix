{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome-tweaks
  ];

  programs.gnome-shell = {
    enable = true;
    extensions = [
      { package = pkgs.gnomeExtensions.dash-to-dock; }
      { package = pkgs.gnomeExtensions.tailscale-qs; }
    ];
  };
}
