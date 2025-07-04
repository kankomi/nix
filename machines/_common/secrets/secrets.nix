let
  vm = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEj4Yzue7s0oz7DlJh0baKy7sqUedJVgFaSCtdgH3f9E grop@nixos";
  grop_laptop = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCo7Nw4G2IeeMuZqmv2UFeWnQPj4KbWCSCvivz2MsPb8hunw6HqVpRns5/ewrSwRvmQ5cLS0MLsrBVMWQJxjBR9cRGqzAXMx1aKvvsmd8fn8k/I6Ln5Im3GopFt30iZ3KrNWr+00oXQnma7I8GnxGPju9TjG/h3j2Y5MggDRDFdyRqLesPmhZRsEgTIHgrH0nfm6SEVuEAJRx4im04yIeO6p/QndGfQrCGNWNtXx7uZPkqZdjtJQ3hnoY1Y6Ww6Gguvcylp0PnWm+mB+R2Fl/2C4rYqBYVRBlQzFRuwj0/SwuzZj1j6wUDLuHxYvt/M9xiLk62cTHtHdXVBsiWNr1fiRM9sR72gxeIPhY6qtkGxhUSni4/2+UWoS8pZc2Ry6aIU7j7aZKA7eEmjdPP2iNOmjF/l7BTUl5WS7bu/awLI24ACkWx+G41yx7dxr4nWvdTfI6PNIVFA8HkEV+xBVIofAjAoWLYa4/QFxC0YKgkwkWNYckDyFFYumsFsSwd8fUE= grop@laptop";
in
{
  "samba.age".publicKeys = [ vm ];
  "hashedUserPassword.age".publicKeys = [
    grop_laptop
    vm
  ];
}
