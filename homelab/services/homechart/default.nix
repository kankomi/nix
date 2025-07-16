{
  config,
  pkgs,
  lib,
  ...
}:

let
  # Fetch and install the Homechart binary
  homechartBin = pkgs.stdenvNoCC.mkDerivation {
    pname = "homechart";
    version = "2025-07-12";
    src = pkgs.fetchurl {
      url = "https://homechart.app/releases/homechart_linux_amd64.gz";
      # Replace with correct hash after running nixos-rebuild once:
      sha256 = "sha256-y4PPjLhAHqUUiqy+rn0DqV7HIpaQq9A9u8bMaIWj2Hw=";
    };
    phases = [
      "unpackPhase"
      "installPhase"
    ];
    unpackPhase = ''
      cp $src homechart.gz
      gunzip homechart.gz
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp homechart $out/bin/homechart
      chmod +x $out/bin/homechart
    '';
  };
  cfg = config.homelab.services.homechart;
in
{
  options.homelab.services.homechart = {
    enable = lib.mkEnableOption "Homechart software and database";
    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/homechart";
      description = "Directory for Homechart persistent data";
    };
    httpPort = lib.mkOption {
      type = lib.types.port;
      default = 3000;
      description = "Port Homechart will listen on";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ homechartBin ];
    # Postgres service and database setup
    services.postgresql = {
      enable = true;
      ensureDatabases = [ "homechart" ];
      ensureUsers = [
        {
          name = "homechart";
          ensureDBOwnership = true;
        }
      ];
      # Default port is 5432; change if you want
    };

    users.users.homechart = {
      isSystemUser = true;
      home = cfg.dataDir;
      createHome = true;
      group = "homechart";
    };
    users.groups.homechart = { };

    # Homechart systemd service
    systemd.services.homechart = {
      description = "Homechart Service";
      wantedBy = [ "multi-user.target" ];
      after = [ "postgresql.service" ];
      requires = [ "postgresql.service" ];
      serviceConfig = {
        User = "homechart";
        Group = "homechart";
        ExecStart = "${homechartBin}/bin/homechart run";
        WorkingDirectory = cfg.dataDir;
        Restart = "on-failure";
      };
      environment = {
        homechart_database_uri = "postgresql://homechart@/homechart?host=/run/postgresql&sslmode=disable";
      };
      # Ensure homechart home dir exists & right permissions
      preStart = ''
        mkdir -p ${cfg.dataDir}
                chown homechart:homechart ${cfg.dataDir}
      '';
    };

    homelab.cloudflared.ingress = {
      "homechart.pgross.de" = "http://localhost:${toString cfg.httpPort}";
    };

    # Open Homechart HTTP port in firewall
    networking.firewall.allowedTCPPorts = [ cfg.httpPort ];
  };
}
