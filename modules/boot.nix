{ pkgs-stable, ... }:

{
  # Bootloader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    plymouth = {
      enable = true;
      theme = "glitch";
      themePackages = with pkgs-stable; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "glitch" ];
        })
      ];
    };
  };

}
