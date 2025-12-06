{ pkgs, user, ... }:

{
  programs = {
    bat = {
      enable = true;
      config = {
        pager = "less -FirSwX";
        theme = "TwoDark";
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };
    carapace = {
      enable = true;
      enableZshIntegration = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    nix-search-tv.enable = true;
    tmux = {
      enable = true;
      prefix = "C-s";
      keyMode = "vi";
      mouse = true;
      newSession = true;
      sensibleOnTop = true;
      extraConfig = ''
        set -ag terminal-overrides ",$TERM:Tc"
        set -gq allow-passthrough on
        set -g base-index 1
        setw -g pane-base-index 1
        set-option -g renumber-windows on
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        set -g status-style fg=#62a0ea 
        set -g status-left "#[fg=#ffbe6f,bold] #S "
        set -g status-left-length 100
        set -g window-status-format "#I:#W"
        set -g window-status-current-format "#[fg=#ffbe6f,bold]#I:#W "
        set -g status-right '#(tmux ls -F " ##S" | grep -v "$(tmux display -p "#{session_name}")" | tr "\\n" " " | sed "s/ $//" )'
        set -g status-justify absolute-centre

        bind-key a display-popup -E -w 50% -h 40% -x C -y C "${./tmux-sessionizer.sh}"
      '';
    };

    # Git and Github CLI
    git = {
      enable = true;
      settings = {
        user = {
          name = user.fullName;
          email = user.email;
        };
        alias = {
          pl = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
          ol = "log --oneline --graph --decorate";
        };
        init.defaultBranch = "main";
        color.ui = true;
        credential.helper = "store";
        pull.rebase = true;
      };
      ignores = [
        "AGENTS.md"
        ".env"
        "*.log"
      ];
    };
    gh.enable = true;

    # Manage secrets
    gpg = {
      enable = true;
      publicKeys = [
        {
          source = ./public-key.txt;
          trust = 5;
        }
      ];
    };
    password-store.enable = true;
  };
}
