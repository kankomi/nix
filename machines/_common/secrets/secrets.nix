let
  vm = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDlS6/r/o4svSuAod+zU8iDMjCk/hPJRtXS9gULlFKLz";
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyc4x14LKYJmV8pD8Zy+8ecCIdecy1oDS5kUUSgG8bT";
in
{
  "samba.age".publicKeys = [ vm ];
  "tailscaleAuthKey.age".publicKeys = [
    vm
    laptop
  ];
  "userHashedPassword.age".publicKeys = [
    laptop
    vm
  ];
  "cloudflared.age".publicKeys = [ vm ];
}
