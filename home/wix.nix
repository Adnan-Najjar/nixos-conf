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
  ];

  home = {
    username = user.username;
    homeDirectory = "/home/${user.username}";
    stateVersion = "25.05";
  };
}
