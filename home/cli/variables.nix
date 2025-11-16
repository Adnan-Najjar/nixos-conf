{ pkgs, user, ... }:

{
  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
    MANPATH = "/usr/share/man:/usr/local/share/man:$MANPATH";
    GOPATH = "$HOME/.go";
    PATH = "$PATH:$GOPATH/bin:$HOME/.local/bin";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
    _ZO_EXCLUDE_DIRS = "/nix:/tmp:/proc:/sys:/dev";
  };
}
