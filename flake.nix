{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # hyprland = {
    #   type = "git";
    #   url = "https://github.com/hyprwm/Hyprland";
    #   submodules = true;
    # };
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    user = "grop";
  in {
    nixosConfigurations = (
      import ./machines {
        inherit (nixpkgs) lib outputs;
        inherit inputs nixpkgs home-manager user;
      }
    );
  };
}
