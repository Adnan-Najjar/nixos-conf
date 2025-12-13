{ pkgs, ... }:
{

  home.packages = (
    with pkgs;
    [
      # Nix
      nil
      nixfmt-classic
      # Lua
      stylua
      # Binary
      unixtools.xxd
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
      nvim-web-devicons
      gitsigns-nvim
      vim-sleuth
      tokyonight-nvim
      nvim-highlight-colors
      lualine-nvim
      mini-files
      snacks-nvim
    ];
    extraLuaConfig = builtins.readFile ./nvim.lua;
  };
}
