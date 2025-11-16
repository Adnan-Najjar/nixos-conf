{ config, pkgs, ... }:

{
  # General desktop configuration
  # This module contains common desktop settings that apply to any desktop environment

  # CUPS for printing
  services.printing.enable = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    papirus-icon-theme
    tesseract
    wl-clipboard
    chromium
    onlyoffice-desktopeditors
    libnotify
  ];

  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = [ "CaskaydiaCove Nerd Font" ];
      };
    };
    packages = [ pkgs.nerd-fonts.caskaydia-cove ];
  };
}
