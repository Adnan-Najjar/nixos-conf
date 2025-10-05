{ pkgs, user, ... }:
{

  imports = [
    ./nvim.nix
    ./zsh.nix
  ];

  home.packages = (
    with pkgs;
    [
      man-pages
      man-pages-posix
      unzip
      ripgrep
      fd
      imagemagick
      ghostscript_headless # PDF
      python313Packages.markitdown # MD
      jq
      htmlq
      btop
      fastfetch
      eza
      tldr
      trash-cli
      gemini-cli
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
      '';
    };

    # Git and Github CLI
    git = {
      enable = true;
      userName = user.fullName;
      userEmail = user.email;
      aliases = {
        prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      };
      extraConfig = {
        init.defaultBranch = "main";
        color.ui = true;
        credential.helper = "store";
      };
      ignores = [ "shell.nix" ];
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
