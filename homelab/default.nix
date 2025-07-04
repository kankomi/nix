{
  config,
  lib,
  ...
}:
let
  cfg = config.homelab;
in
{
  options.homelab = {
    enable = lib.mkEnableOption {
      default = true;
    };
    user = lib.mkOption {
      type = lib.types.str;
      default = "share";
      description = "The user the services will run as";
    };
    group = lib.mkOption {
      type = lib.types.str;
      default = "share";
      description = "The group the services will run as";
    };
    servicePath = lib.mkOption {
      type = lib.types.str;
      default = "/usr/share/services";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d ${cfg.servicePath} 0750 ${cfg.user} ${cfg.user} - -"
    ];
    users = {
      groups.${cfg.user}.gid = 993;
      users.${cfg.user} = {
        uid = 993;
        isSystemUser = true;
        group = cfg.group;
      };
    };
  };

  imports = [
    ./services
    ./samba
  ];
}
