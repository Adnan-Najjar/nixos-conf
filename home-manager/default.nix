{ user, ... }:

{
  imports = [
    ./cli
  ];

  home = {
    username = user.username;
    homeDirectory = "/home/${user.username}";
    stateVersion = "25.05";

    sessionVariables = {
      MANPATH = "/usr/share/man:/usr/local/share/man:$MANPATH";
      GOPATH = "$HOME/.go";
      PATH = "$PATH:$HOME/.go/bin:$HOME/.local/bin";
      MANPAGER = "sh -c 'awk '''{ gsub(/x1B[[0-9;]*m/, \"\", $0); gsub(/.x08/, \"\", $0); print }''' | bat -p -lman'";
    };
  };

}
