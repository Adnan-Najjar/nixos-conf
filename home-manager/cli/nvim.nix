{ pkgs, ... }:
{

  home.packages = (
    with pkgs;
    [
      # C
      gcc
      # Go
      go
      gopls
      # Bash
      bash-language-server
      # Nix
      nil
      nixfmt-classic
      # Lua
      stylua
      lua-language-server
      # Python
      python3
      pyright
    ]
  );

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      markview-nvim
      vim-illuminate
      nvim-web-devicons
      gitsigns-nvim
      vim-sleuth
      tokyonight-nvim
      lualine-nvim
      mini-pick
      mini-files
      undotree
    ];
    extraLuaConfig = builtins.readFile ./nvim.lua;
  };
}
