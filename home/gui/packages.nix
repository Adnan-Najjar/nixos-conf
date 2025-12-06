{ pkgs, ... }:

{
  home.packages = with pkgs; [
    easyeffects
    marktext
    libreoffice
    poppler-utils
  ];
}
