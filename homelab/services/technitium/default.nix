{
  config,
  lib,
  ...
}:
let
  service = "technitium";
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
    services.technitium = {
      enable = true;
      openFirewall = true;
      user = homelab.user;
      group = homelab.user;
      logDir = "/var/log/technitium";
    };
  };
}
