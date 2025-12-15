{
  lib,
  pkgs-stable,
  user,
  inputs,
  ...
}:

{
  imports = [
    # Hardware configuration
    ../hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
    inputs.home-manager.nixosModules.home-manager

    # Core NixOS modules
    ../modules/nix.nix
    ../modules/services.nix
    ../modules/programs.nix
    ../modules/users.nix

    # Core system modules
    ../modules/boot.nix
    ../modules/networking.nix
    ../modules/locale.nix
    ../modules/system.nix

    # Desktop and GUI modules
    ../modules/desktop.nix
    ../modules/gnome.nix
    ../modules/audio.nix

    # Virtualization support
    ../modules/virtualization.nix

    # Custom
    ../modules/nixec
  ];

  # System configuration
  programs = {
    zsh.enable = true;
    steam.enable = true;
    kdeconnect = {
      enable = true;
      package = pkgs-stable.gnomeExtensions.gsconnect;
    };
  };

  # environment.systemPackages = with pkgs; [ ];

  # User configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit user inputs pkgs-stable;
      isWSL = false;
    };
    users.${user.username}.imports = [ ../home/nixos.nix ];
  };

  # Server specialisation
  specialisation = {
    server = {
      inheritParentConfig = true;
      configuration = {
        # Disable GUI components
        services.displayManager.gdm.enable = lib.mkForce false;
        services.desktopManager.gnome.enable = lib.mkForce false;
      };
    };
  };
}
