{
  config,
  inputs,
  pkgs,
  lib,
  user,
  ...
}:

# if errors we may need to add lib to the gnome-theme inherit
let
  theme = pkgs.sweet;
  themeName = "Sweet-Ambar-Blue-Dark-v40";
in
{
  imports = [
    (import ./gnome-theme.nix { inherit theme themeName; })
    (import ./dconf.nix { inherit theme themeName lib; })
  ];

  home = {
    packages = (
      with pkgs.gnomeExtensions;
      [
        arcmenu
        caffeine
        blur-my-shell
        dash-in-panel
        clipboard-indicator
        appindicator
        athantimes
        user-themes
        wifi-qrcode
        auto-move-windows
        grand-theft-focus
      ]
    );

    # Setup wallpaper
    file = {
      "${config.home.homeDirectory}/Pictures/wallpaper.png".source = ./wallpaper.png;
    };

  };

  # Open Terminal and Browser on startup
  xdg.autostart = {
    enable = true;
    entries = [
      "${pkgs.ghostty}/share/applications/com.mitchellh.ghostty.desktop"
      "${inputs.zen-browser.packages.${pkgs.system}.default}/share/applications/zen-beta.desktop"
    ];
  };
}
