{
  config,
  isWSL,
  lib,
  ...
}:
{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreAllDups = true;
      size = 10000;
      save = 10000;
    };

    shellAliases = lib.mkMerge [
      {
        cat = "bat";
        ip = "ip -c";
        rm = "trash -v";
        mkdir = "mkdir -p";
        pst = "wl-paste";
        cpy = "wl-copy";
        urls = "grep -oP -N --color=never 'http[s]?://\\S+'";
        ".." = "cd ..";
        ls = "eza --icons=auto";
        la = "eza -a --icons=auto";
        ll = "eza -l --icons=auto --total-size";
        lt = "eza --icons=auto --tree -I .git --group-directories-first";
        nrs = "sudo nixos-rebuild switch --flake /etc/nixos";
        open = "xdg-open";
      }
      (lib.mkIf isWSL {
        pst = lib.mkForce "win32yank.exe -o";
        cpy = lib.mkForce "win32yank.exe -i";
        open = lib.mkForce "explorer.exe";
      })
    ];

    initContent = ''
      # Completion cache path setup
      typeset -g compfile="$HOME/.cache/.zcompdump"

      if [[ -d "$comppath" ]]; then
              [[ -w "$compfile" ]] || rm -rf "$compfile" >/dev/null 2>&1
      fi

      WORDCHARS=''${WORDCHARS//\/} # Don't consider '/' character part of the word

      # Configure key keybindings
      bindkey -e                                        # emacs key bindings
      bindkey ' ' magic-space                           # do history expansion on space
      bindkey '^[[1;5C' forward-word                    # ctrl + ->
      bindkey '^[[1;5D' backward-word                   # ctrl + <-

      # Open command in editor
      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey '^X' edit-command-line                    # ctrl + x

      # Override -h and --help with bat
      alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
      alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

      if ! [ $NVIM ]; then
        clear; fastfetch -c examples/9.jsonc
        if ! [ $TMUX ]; then
          ${./tmux-sessionizer.sh}
        fi
      fi
    '';
  };

}

