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
    services.cloudflared = {
      enable = true;
      tunnels = {
        "5819975d-bd2a-4459-bd1a-d26d0399b50d" = {
          credentialsFile = config.age.secrets.cloudflared.path;
          default = "http_status:404";
          ingress = {
            "jellyfin.pgross.de" = "http://localhost:8096";
          };
        };
      };
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
