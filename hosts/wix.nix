{ config, pkgs, user, inputs, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    inputs.home-manager.nixosModules.home-manager

    # Core NixOS modules
    ../modules/nix.nix
    ../modules/users.nix
    ../modules/services.nix
    ../modules/system.nix
    ../modules/programs.nix
  ];

  # System configuration
  wsl.enable = true;
  wsl.defaultUser = user.username;

  # User configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit user inputs;
      isWSL = true;
    };
    users.${user.username}.imports = [ ../home/wix.nix ];
  };

  # environment.systemPackages = with pkgs; [ ];
}
