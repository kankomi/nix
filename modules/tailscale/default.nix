{ pkgs, config, ... }:
{
  # needed for dns to work
  services.resolved.enable = true;

  environment.systemPackages = [ pkgs.tailscale ];

  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  services.tailscale = {
    enable = true;
    # useRoutingFeatures = "both";
    authKeyFile = config.age.secrets.tailscaleAuthKey.path;
    extraUpFlags = [
      # "--reset"
      # "--advertise-exit-node"
      # "--accept-dns=false"
    ];
  };
}
