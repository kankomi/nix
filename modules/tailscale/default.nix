{ pkgs, config, ... }:
{
  # needed for dns to work
  services.resolved.enable = true;

  boot.kernel.sysctl = {
    # if you use ipv4, this is all you need
    "net.ipv4.conf.all.forwarding" = true;
  };

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
      "--advertise-routes=192.168.1.0/24"
    ];
  };
}
