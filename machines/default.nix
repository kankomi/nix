{
  inputs,
  nixpkgs,
  agenix,
  home-manager,
  user,
  ...
}: let
  # system = "x86_64-linux";
  #
  # pkgs = import nixpkgs {
  #   inherit system;
  #   config.allowUnfree = true;
  # };
  lib = nixpkgs.lib;
  agenixModule = agenix.nixosModules.default;
in {
  inputs.agenix.url = "github:ryantm/agenix";

  laptop = lib.nixosSystem {
    specialArgs = {inherit inputs user;};
    modules = [
      ./laptop/configuration.nix
      agenixModule
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
    specialArgs = {inherit inputs user agenix;};
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
        };
        home-manager.users.${user}.imports = [../home-manager/machines/vm.nix];
      }
    ];
  };
}
