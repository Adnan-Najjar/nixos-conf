{ config, user, ... }:

{
  imports = [
    ./cli/packages.nix
    ./cli/programs.nix
    ./cli/variables.nix
    ./cli/zsh.nix
    ./cli/nvim.nix
    ./cli/autosave.nix
    ./cli/opencode
    ./gui/packages.nix
    ./gui/ghostty.nix
    ./gui/zen-browser.nix
    ./gui/discord.nix
    ./gui/gopray.nix
    ./gui/gnome
  ];

  home = {
    username = user.username;
    homeDirectory = "/home/${user.username}";
    stateVersion = "25.05";
  };

  # Virt-manager settings
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
