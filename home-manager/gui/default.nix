{ pkgs, ... }:
{
  imports = [
    ./ghostty.nix
    ./zen-browser.nix
    ./discord.nix
    ./gnome
  ];
  home.packages = (
    with pkgs;
    [
      gnome-tweaks
      easyeffects
    ]
  );
}
