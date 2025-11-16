{ config, pkgs, ... }:

{
  # Enable GDM and add wallpaper
  services.displayManager.gdm.enable = true;
  nixpkgs.overlays = [
    (final: prev: {
      gnome-shell = prev.gnome-shell.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          (builtins.toFile "gdm-background.patch" ''
            --- a/data/theme/gnome-shell-sass/widgets/_login-lock.scss
            +++ b/data/theme/gnome-shell-sass/widgets/_login-lock.scss
            @@ -15,4 +15,6 @@
             /* Login Dialog */
             .login-dialog {
               background-color: $_gdm_bg;
            +  background-image: url('file:///etc/nixos/home/gui/gnome/lockscreen.png');
            +  background-repeat: repeat;
             }
          '')
        ];
      });
    })
  ];

  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (
    with pkgs;
    [
      cheese # Webcam app
      snapshot # Camera app
      simple-scan # Scanner utility
      geary # Email reader
      evince # Document viewer
      yelp # Help viewer
      epiphany # Web browser
      orca # Screen reader
      seahorse # Passwords and keys
      gnome-connections
      gnome-console
      gnome-photos
      gnome-tour
      gnome-user-docs
      gnome-maps
      gnome-contacts
      gnome-software
      gnome-logs
      gnome-music
    ]
  );
}