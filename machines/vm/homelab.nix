{ ... }:
{
  homelab = {
    enable = true;
    services = {
      enable = true;
      jellyfin.enable = true;
      homechart.enable = true;
    };
  };
}
