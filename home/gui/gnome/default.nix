{
  config,
  inputs,
  pkgs,
  pkgs-stable,
  lib,
  ...
}:

let
  theme = pkgs-stable.sweet;
  themeName = "Sweet-Ambar-Blue-Dark-v40";
in
{
  imports = [
    (import ./gnome-theme.nix { inherit theme themeName; })
    (import ./dconf.nix { inherit theme themeName lib; })
  ];

  home = {
    packages =
      with pkgs-stable;
      [
        gnome-tweaks
      ]
      ++ (with gnomeExtensions; [
        arcmenu
        caffeine
        blur-my-shell
        dash-in-panel
        clipboard-indicator
        appindicator
        user-themes
        wifi-qrcode
        auto-move-windows
      ]);

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
      "${
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      }/share/applications/zen-beta.desktop"
    ];
  };
}
