{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gradia
    easyeffects
    marktext
    libreoffice
    poppler-utils

    heroic
  ];
}
