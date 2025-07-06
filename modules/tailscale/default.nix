{ pkgs, config, ... }:
{
  # needed for dns to work
  services.resolved.enable = true;

  environment.systemPackages = [ pkgs.tailscale ];

  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  # global nameservers need to be disabled on tailscale.com
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
