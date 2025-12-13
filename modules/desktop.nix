{ pkgs-stable, ... }:

{
  # General desktop configuration
  # This module contains common desktop settings that apply to any desktop environment

  # CUPS for printing
  services.printing.enable = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs-stable; [
    papirus-icon-theme
    chromium
  ];

  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = [ "CaskaydiaCove Nerd Font" ];
      };
    };
    packages = [ pkgs-stable.nerd-fonts.caskaydia-cove ];
  };
}
