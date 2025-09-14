{ pkgs, inputs, ... }:

let
  python-with-my-plugins = pkgs.python312.withPackages (ps: with ps; [
    # debugpy
    python-lsp-server
    ruff
  ]);

  vim-jukit = pkgs.vimUtils.buildVimPlugin {
    pname = "vim-jukit";
    version = "1.4.1";
    src = pkgs.fetchFromGitHub {
      owner = "luk400";
      repo = "vim-jukit";
      rev = "32514c68d7f1961a57b821c0021c9a0a9e4be9c1";
      sha256 = "sha256-GUqYNRLGXaPyYm09rthoXbtV0sNjElEY1aSfK3X32mk=";
    };
  };
in
{
  nixpkgs.config.allowUnfree = true;
  programs = {
    neovim = {
      enable = true;
      withNodeJs = true;
      extraPackages = with pkgs; [
        ripgrep
        codeium
        python-with-my-plugins
        bash-language-server
        vscode-langservers-extracted
        nodePackages.typescript
        nodePackages.typescript-language-server
        nodePackages.eslint
        black
        # pyright
        basedpyright
        gopls
        clang-tools
        clang
        lua-language-server
        universal-ctags
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
        bufferline-nvim
        cmp_luasnip
        indent-blankline-nvim
        lspkind-nvim
        nvim-colorizer-lua
        comment-nvim
        vim-commentary
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
        nvim-dap-rr
        nvim-dap-rego
        nvim-tree-lua
        nvim-web-devicons
        nvim-ufo
        refactoring-nvim
        nvim-treesitter.withAllGrammars
        telescope-nvim
        telescope-dap-nvim
        telescope-fzf-native-nvim
        tokyonight-nvim
        which-key-nvim
        codeium-vim
        codeium-nvim
        vim-jukit
        tagbar
      ];
      extraLuaConfig = ''
        ${builtins.readFile ./options.lua}
        ${builtins.readFile ./keymaps.lua}
        ${builtins.readFile ./plugins/alpha.lua}
        ${builtins.readFile ./plugins/auto-session.lua}
        ${builtins.readFile ./plugins/autopairs.lua}
        ${builtins.readFile ./plugins/blankline.lua}
        ${builtins.readFile ./plugins/bufferline.lua}
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
        vim.cmd('source ${./plugins/vim-jukit.vim}')
      '';
    };
  };
}
