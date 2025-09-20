{ pkgs, user, ... }:

{
  imports = [
    ./cli
  ];

  home = {
    username = user.username;
    homeDirectory = "/home/${user.username}";
    stateVersion = "25.05";

    sessionVariables = {
      SHELL = "${pkgs.zsh}/bin/zsh";
      MANPATH = "/usr/share/man:/usr/local/share/man:$MANPATH";
      GOPATH = "$HOME/.go";
      PATH = "$PATH:$HOME/.go/bin:$HOME/.local/bin";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
      _ZO_EXCLUDE_DIRS = "/nix:/tmp:/proc:/sys:/dev";
    };
  };

}
