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
        cp = "cp -i";
        mv = "mv -i";
        rm = "trash -v";
        mkdir = "mkdir -p";
        pst = "wl-paste";
        cpy = "wl-copy";
        urls = "grep -oP -N --color=never 'http[s]?://\\S+'";
        ppt2txt = "unzip -qc \"$1\" \"ppt/slides/slide*.xml\" | grep -oP '(?<=\\<a:t\\>).*?(?=\\</a:t\\>)'";
        ".." = "cd ..";
        ls = "eza --icons";
        la = "eza -a --icons";
        ll = "eza -l --icons --total-size";
        lt = "eza --icons --tree -I .git --group-directories-first";
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
      bindkey '^X' edit-command-line                    # ctrl + x to open in editor
      # Override -h and --help with bat
      alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
      alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

      # Dont open tmux in tty or ssh
      if [[ $(tty) == *"pts"* ]]; then
              if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
                      tmux attach -t main &> /dev/null || tmux new -s main &> /dev/null 
              fi
      fi

      clear; fastfetch -c examples/9.jsonc
    '';
  };

}
