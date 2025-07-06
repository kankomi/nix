{ pkgs, config, ... }:
{
  # curl -fsSL https://tailscale.com/install.sh | sh && sudo tailscale up --auth-key=tskey-auth-kSUpXpVjpg11CNTRL-uhgDp9yjzTTDEJfFRM9JSTH4UnHEHe1m
  environment.systemPackages = [ pkgs.tailscale ];

  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  services.tailscale = {
    enable = true;
    authKeyFile = config.age.secrets.tailscaleAuthKey.path;
    # extraUpFlags = [
    #   ];
  };
}
