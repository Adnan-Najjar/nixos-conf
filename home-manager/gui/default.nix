{ pkgs, ... }:
{
  imports = [
    ./ghostty.nix
    ./zen-browser.nix
    ./gnome
  ];
  home.packages = (with pkgs; [ gnome-tweaks ]);
}
