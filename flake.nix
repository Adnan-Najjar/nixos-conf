{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixos-hardware,
      nixos-wsl,
      home-manager,
      zen-browser,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      user = {
        username = "adnan";
        fullName = "Adnan Najjar";
        email = "adnan.najjar1@gmail.com";
      };

    in
    {
      nixosConfigurations = {

        # NixOS
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit user inputs; };
          modules = [
            ./hosts/nixos.nix
          ];
        };

        # Windows WSL
        wix = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit user inputs; };
          modules = [
            ./hosts/wix.nix
          ];
        };

      };
    };
}
