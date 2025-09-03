{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
      nixos-wsl,
      home-manager,
      zen-browser,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      user = {
        hostname = "nixos";
        username = "adnan";
        fullName = "Adnan Najjar";
        email = "adnan.najjar1@gmail.com";
        password = "$6$uRBlD/dWnsMHsLMJ$Q1PoJOfq1.wAFiqBS78wC69VVZpbPFirZzPa3BrOMEBSr6RyK2hMEp6XZ7Dya3bOPbnIEzl2JvfhZbMRMdRdY1";
      };

      homeManager = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.${user.username}.imports = [
          ./home-manager
        ];
        home-manager.extraSpecialArgs = {
          inherit user inputs;
        };
      };

    in
    {
      nixosConfigurations = {

        os = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit user inputs; };
          modules = [
            ./configuration.nix
            ./configuration-common.nix
            ./hardware-configuration.nix
            ./laptop.nix
            home-manager.nixosModules.home-manager
            homeManager
            {
              home-manager.users.${user.username}.imports =
                homeManager.home-manager.users.${user.username}.imports
                ++ [ ./home-manager/gui ];
              home-manager.extraSpecialArgs = homeManager.home-manager.extraSpecialArgs // {
                isWSL = false;
              };
            }
          ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit user inputs; };
          modules = [
            ./configuration-common.nix
            nixos-wsl.nixosModules.default
            {
              system.stateVersion = "25.05";
              wsl.enable = true;
              wsl.defaultUser = user.username;
            }
            home-manager.nixosModules.home-manager
            homeManager
            {
              home-manager.extraSpecialArgs = homeManager.home-manager.extraSpecialArgs // {
                isWSL = true;
              };
            }

          ];
        };

      };
    };
}
