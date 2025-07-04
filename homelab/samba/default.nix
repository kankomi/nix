{
  config,
  pkgs,
  lib,
  ...
}:
let
  id = config.users.users.${config.homelab.user}.uid;
  opts = "uid=${toString id},gid=${toString id},x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  creds = config.age.secrets.samba.path;
  host = "192.168.1.251";
in
{
  config = lib.mkIf config.homelab.enable {
    # For mount.cifs, required unless domain name resolution is not needed.
    environment.systemPackages = [ pkgs.cifs-utils ];
    fileSystems."/mnt/nas_media" = {
      device = "//${host}/media";
      fsType = "cifs";
      options =
        let
          # this line prevents hanging on network split
          automount_opts = opts;
        in
        [
          "${automount_opts},credentials=${creds}"
          "ro"
          # "file_mode=744"
          # "dir_mode=744"
        ];
    };
    fileSystems."/mnt/nas_photos" = {
      device = "//${host}/photos";
      fsType = "cifs";
      options =
        let
          # this line prevents hanging on network split
          automount_opts = opts;
        in
        [
          "${automount_opts},credentials=${creds}"
          "ro"
          "file_mode=744"
          "dir_mode=744"
        ];
    };
    fileSystems."/mnt/nas_backup" = {
      device = "//${host}/backup";
      fsType = "cifs";
      options =
        let
          # this line prevents hanging on network split
          automount_opts = opts;
        in
        [
          "${automount_opts},credentials=${creds}"
          "file_mode=600"
          "dir_mode=600"
        ];
    };
  };
}
