{
  services,
  pkgs,
  ...
}: {
  # services.udisks2.enable = true;
  # services.gvfs.enable = true;

  services.udiskie = {
    enable = true;
    automount = false;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # replace with your favorite file manager
        file_manager = "${pkgs.xdg-utils}/bin/xdg-open";

        #   file_manager = "${pkgs.nautilus}/bin/nautilus"
      };
    };
  };
}
