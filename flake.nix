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
        hostname = "nixos";
        username = "adnan";
        fullName = "Adnan Najjar";
        email = "adnan.najjar1@gmail.com";
      };

      baseImports = [ ./home-manager ];

      homeManager = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.${user.username}.imports = baseImports;
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
            ./virtualization.nix
            ./configuration-common.nix
            ./hardware-configuration.nix
            nixos-hardware.nixosModules.asus-zephyrus-ga401
            home-manager.nixosModules.home-manager
            homeManager
            {
              home-manager.users.${user.username}.imports = baseImports ++ [ ./home-manager/gui ];
              home-manager.extraSpecialArgs = homeManager.home-manager.extraSpecialArgs // {
                isWSL = false;
                isHM = false;
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
                isHM = false;
              };
            }

          ];
        };

      };

      homeConfigurations.hm = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = system;
          config = {
            allowUnfree = true;
            experimental-features = [
              "nix-command"
              "flakes"
            ];
          };
        };
        modules = [
          ./home-manager
          {
            home.username = user.username;
            home.homeDirectory = "/home/${user.username}";
          }
        ];
        extraSpecialArgs = {
          inherit user inputs;
          isWSL = false;
          isHM = true;
        };
      };
    };
}
