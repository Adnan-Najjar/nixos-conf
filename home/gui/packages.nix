{ pkgs, ... }:

{
  home.packages = with pkgs; [
    easyeffects
    marktext
  ];
}
