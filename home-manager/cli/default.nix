{ pkgs, user, ... }:
{

  imports = [
    ./nvim.nix
    ./zsh.nix
    ./autosave.nix
    ./opencode
  ];

  home.packages = (
    with pkgs;
    [
      man-pages
      man-pages-posix
      file
      unzip
      p7zip
      ripgrep
      fd
      android-tools
      imagemagick
      ghostscript_headless # PDF
      python313Packages.markitdown # MD
      ffmpeg
      jq
      htmlq
      btop
      fastfetch
      eza
      tldr
      trash-cli
      fahclient
    ]
  );

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
    tmux = {
      enable = true;
      prefix = "C-s";
      keyMode = "vi";
      mouse = true;
      newSession = true;
      sensibleOnTop = true;
      extraConfig = ''
        set -ag terminal-overrides ",$TERM:Tc"
        set-option -g status-style bg=default
        set -gq allow-passthrough on
        bind-key a display-popup -E -w 50% -h 40% -x C -y C "${./tmux-sessionizer.sh}"
      '';
    };

    # Git and Github CLI
    git = {
      enable = true;
      userName = user.fullName;
      userEmail = user.email;
      aliases = {
        pl = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
        ol = "log --oneline --graph --decorate";
      };
      extraConfig = {
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
