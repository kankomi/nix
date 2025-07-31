{
  inputs,
  nixpkgs,
  home-manager,
  user,
  ...
}:
let
  # system = "x86_64-linux";
  #
  # pkgs = import nixpkgs {
  #   inherit system;
  #   config.allowUnfree = true;
  # };
  lib = nixpkgs.lib;
  agenixModule = inputs.agenix.nixosModules.default;
in
{
  inputs.agenix.url = "github:ryantm/agenix";

  laptop = lib.nixosSystem {
    specialArgs = { inherit inputs user; };
    modules = [
      ./laptop/configuration.nix
      agenixModule
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user inputs;
          configName = "laptop";
        };
        home-manager.users.${user}.imports = [ ../home-manager/machines/laptop.nix ];
      }
    ];
  };
  bosch_vm = lib.nixosSystem {
    specialArgs = { inherit inputs; user="gpa9bh"; };
    modules = [
      ./bosch_vm/configuration.nix
      agenixModule
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user inputs;
          configName = "bosch_vm";
        };
        home-manager.users.gpa9bh.imports = [ ../home-manager/machines/bosch_vm.nix ];
      }
    ];
  };
  vm = lib.nixosSystem {
    specialArgs = { inherit inputs user; };
    modules = [
      ../homelab
      ./vm/configuration.nix
      agenixModule
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user inputs;
          configName = "vm";
        };
        home-manager.users.${user}.imports = [ ../home-manager/machines/vm.nix ];
      }
    ];
  };
}
