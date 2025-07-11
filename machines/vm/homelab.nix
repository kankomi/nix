{ ... }:
{
  homelab = {
    enable = true;
    services = {
      enable = true;
      jellyfin.enable = true;
      technitium.enable = true;
    };
  };
}
