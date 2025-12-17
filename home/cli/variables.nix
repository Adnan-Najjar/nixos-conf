{ pkgs-unstable, user, ... }:

{
  home.sessionVariables = {
    SHELL = "${pkgs-unstable.zsh}/bin/zsh";
    PATH = "$PATH:$GOPATH/bin:$HOME/.local/bin";
    GOPATH = "$HOME/.go";
    MANPATH = "/usr/share/man:/usr/local/share/man:$MANPATH";
    MANPAGER = "nvim +Man!";
    MANWIDTH = 999;
    _ZO_EXCLUDE_DIRS = "/nix:/tmp:/proc:/sys:/dev";
  };
}
