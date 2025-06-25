{
  lib,
  inputs,
  nixpkgs,
  home-manager,
  user,
  ...
}: let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in {
  laptop = lib.nixosSystem {
    specialArgs = {inherit inputs user;};
    modules = [
      ./laptop/configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user inputs;
        };
        home-manager.users.${user}.imports = [../home-manager/machines/laptop.nix];
      }
    ];
  };
  vm = lib.nixosSystem {
    specialArgs = {inherit inputs user;};
    modules = [
      ./vm/configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user inputs;
        };
        home-manager.users.${user}.imports = [../home-manager/machines/vm.nix];
      }
    ];
  };
}
