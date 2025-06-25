{
  config,
  lib,
  ...
}: let
  service = "jellyfin";
  cfg = config.homelab.services.${service};
  homelab = config.homelab;
in {
  options.homelab.services.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service}";
    };
    configDir = lib.mkOption {
      type = lib.types.str;
      default = "${homelab.servicePath}/${service}";
    };
    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/mnt/nas_media/test";
    };
    logDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/log/${service}";
    };
  };

  config = lib.mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      user = homelab.user;
      group = homelab.user;
      dataDir = cfg.dataDir;
      configDir = cfg.configDir;
      logDir = cfg.logDir;
    };
  };
}
