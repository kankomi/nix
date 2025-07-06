{ config, lib, ... }:
let
  cfg = config.homelab.cloudflared;
in
{
  options.homelab.cloudflared = {
    ingress = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      example = {
        "jellyfin.pgross.de" = "http://localhost:8096";
      };
    };
  };

  config = lib.mkIf config.homelab.services.enable {
    services.cloudflared = {
      enable = true;
      tunnels = {
        "5819975d-bd2a-4459-bd1a-d26d0399b50d" = {
          credentialsFile = config.age.secrets.cloudflared.path;
          default = "http_status:404";
          ingress = cfg.ingress;
        };
      };
    };
  };
}
