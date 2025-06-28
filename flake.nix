{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-davinci.url = "github:NixOS/nixpkgs/d202f48f1249f013aa2660c6733e251c85712cbe";

    agenix.url = "github:ryantm/agenix";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixpkgs-davinci,
    agenix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    user = "grop";
    pkgs-davinci = nixpkgs-davinci.legacyPackages.${system};
  in {
    nixosConfigurations = (
      import ./machines {
        inherit (nixpkgs) lib outputs;
        inherit inputs nixpkgs home-manager pkgs-davinci agenix system user;
      }
    );
  };
}
