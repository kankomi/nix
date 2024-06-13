{
  pkgs,
  ...
}:{
  programs.gnome-shell = {
    enable = true;
    extensions = [
      { package = pkgs.gnomeExtensions.dash-to-dock; }
    ];
  };
}
