{...}: {
  age.secrets.samba-creds = {
    file = ./samba.age;
    owner = "root";
    group = "root";
    mode = "600";
  };
}
