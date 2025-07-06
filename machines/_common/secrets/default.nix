{ ... }:
{
  age.identityPaths = [
    "/home/grop/.ssh/id_ed25519"
    "/home/grop/.ssh/id_rsa"
    "/etc/ssh/ssh_host_ed25519_key"
  ];

  age.secrets = {
    samba = {
      file = ./samba.age;
      owner = "root";
      group = "root";
      mode = "600";
    };

    userHashedPassword.file = ./userHashedPassword.age;
    tailscaleAuthKey.file = ./tailscaleAuthKey.age;
    cloudflared.file = ./cloudflared.age;
  };
}
