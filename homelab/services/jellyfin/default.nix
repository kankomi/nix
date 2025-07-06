{
  config,
  lib,
  ...
}:
let
  service = "jellyfin";
  cfg = config.homelab.services.${service};
  homelab = config.homelab;
in
{
  options.homelab.services.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service}";
    };
  };

  config = lib.mkIf cfg.enable {
    homelab.cloudflared.ingress = {
      "jellyfin.pgross.de" = "http://localhost:8096";
    };
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      user = homelab.user;
      group = homelab.user;
      logDir = "/var/log/jellyfin";
    };
  };
}
