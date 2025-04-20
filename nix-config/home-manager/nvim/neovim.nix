{ pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs = {
    neovim = {
      enable = true;
      withNodeJs = true;
      extraPackages = with pkgs; [
        codeium
      ];
      plugins = with pkgs.vimPlugins; [
        alpha-nvim
        auto-session
        nvim-autopairs
        cmp-path
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        luasnip
        cmp_luasnip
        indent-blankline-nvim
        lspkind-nvim
        nvim-colorizer-lua
        comment-nvim
        # vim-commentary
        todo-comments-nvim
        nvim-ts-context-commentstring
        nvim-lspconfig
        SchemaStore-nvim
        lualine-nvim
        noice-nvim
        nvim-dap
        nvim-dap-ui
        nvim-dap-virtual-text
        nvim-dap-python
        nvim-dap-go
        nvim-tree-lua
        nvim-web-devicons
        nvim-ufo
        refactoring-nvim
        nvim-treesitter.withAllGrammars
        telescope-nvim
        telescope-fzf-native-nvim
        tokyonight-nvim
        which-key-nvim
        codeium-vim
        codeium-nvim
      ];
      extraLuaConfig = ''
        ${builtins.readFile ./options.lua}
        ${builtins.readFile ./keymaps.lua}
        ${builtins.readFile ./plugins/alpha.lua}
        ${builtins.readFile ./plugins/auto-session.lua}
        ${builtins.readFile ./plugins/autopairs.lua}
        ${builtins.readFile ./plugins/blankline.lua}
        ${builtins.readFile ./plugins/cmp.lua}
        ${builtins.readFile ./plugins/colorizer.lua}
        ${builtins.readFile ./plugins/comment.lua}
        ${builtins.readFile ./plugins/formatter.lua}
        ${builtins.readFile ./plugins/lsp.lua}
        ${builtins.readFile ./plugins/lualine.lua}
        ${builtins.readFile ./plugins/noice.lua}
        ${builtins.readFile ./plugins/nvim-dap.lua}
        ${builtins.readFile ./plugins/nvim-tree.lua}
        ${builtins.readFile ./plugins/nvim-ufo.lua}
        ${builtins.readFile ./plugins/refactoring.lua}
        ${builtins.readFile ./plugins/telescope.lua}
        ${builtins.readFile ./plugins/themes.lua}
        ${builtins.readFile ./plugins/todo-comments.lua}
        ${builtins.readFile ./plugins/treesitter.lua}
        ${builtins.readFile ./plugins/vim-markdown.lua}
        ${builtins.readFile ./plugins/which-key.lua}
      '';
    };
  };
}
