{ ... }:
{
  age.identityPaths = [ "/home/grop/.ssh" ];
  age.secrets = {

    samba-creds = {
      file = ./samba.age;
      owner = "root";
      group = "root";
      mode = "600";
    };

    userHashedPassword.file = ./userHashedPassword.age;
  };
}
