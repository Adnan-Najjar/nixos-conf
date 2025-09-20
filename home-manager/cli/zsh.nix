{
  config,
  isWSL,
  isHM,
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
        nrs = "sudo nixos-rebuild switch --flake /etc/nixos#os";
        gemini = "GEMINI_API_KEY=$(pass api/gemini) gemini";
        open = "xdg-open &>/dev/null &; disown";
      }
      (lib.mkIf isWSL {
        pst = lib.mkForce "win32yank.exe -o";
        cpy = lib.mkForce "win32yank.exe -i";
        nrs = lib.mkForce "sudo nixos-rebuild switch --flake /etc/nixos#wsl";
        open = lib.mkForce "explorer.exe";
      })
      (lib.mkIf isHM {
        nrs = lib.mkForce "nix run home-manager -- switch --flake $HOME/.config/home-manager#hm";
      })
    ];

    initContent = ''
      # Completion cache path setup
      typeset -g compfile="$HOME/.cache/.zcompdump"

      if [[ -d "$comppath" ]]; then
              [[ -w "$compfile" ]] || rm -rf "$compfile" >/dev/null 2>&1
      fi

      WORDCHARS=''${WORDCHARS//\/} # Don't consider '/' character part of the word

      # configure key keybindings
      bindkey -e                                        # emacs key bindings
      bindkey ' ' magic-space                           # do history expansion on space
      bindkey '^[[1;5C' forward-word                    # ctrl + ->
      bindkey '^[[1;5D' backward-word                   # ctrl + <-
      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey '^X' edit-command-line                    # ctrl + x to open in editor
      # Override -h and --help with bat
      alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
      alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

      # If not running interactively, don't do anything
      case $- in
          *i*) ;;
            *) return;;
      esac

      clear; fastfetch -c examples/9.jsonc

      if ! [ $TMUX ] && ! [ $NVIM ]; then
          dir=$(zoxide query -i) 2>/dev/null
          session_name=$(basename "$dir" | tr ' .-' '___' | cut -c1-7)
          if [ -n "$dir" ]; then
              tmux new-session -A -s "$session_name" -c "$dir"
          fi
      fi
    '';
  };

}
