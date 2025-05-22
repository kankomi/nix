{
  config,
  pkgs,
  ...
}: {
  services.trezord.enable = true;
  services.udev.packages = with pkgs; [trezor-udev-rules];
  home.packages = with pkgs; [
    trezor-suite
    trezorctl
  ];
}
