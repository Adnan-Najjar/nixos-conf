{ pkgs, ... }:
{
  imports = [
    ./ghostty.nix
    ./obsidian.nix
    ./zen-browser.nix
    ./gnome
  ];
  home.packages = (with pkgs; [ gnome-tweaks ]);
}
