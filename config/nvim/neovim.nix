{ pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      extraPackages = with pkgs; [
        delve
        ctags
        python311Packages.debugpy
        ripgrep
        nodePackages.npm
        nodejs
        black
        clang-tools
        clang
        lua-language-server
        # gofmt
        gopls
        xclip
        wl-clipboard
        luajitPackages.lua-lsp
        nil
        rust-analyzer
        nodePackages.bash-language-server
        yaml-language-server
        pyright
        marksman
      ];
      plugins = with pkgs.vimPlugins; [
        lsp-inlayhints-nvim
        # vim-rooter
        cmp-path
        colorizer
        nvim-cokeline
        vim-commentary
        tagbar
        noice-nvim
        nvim-dap
        nvim-dap-ui
        nvim-dap-virtual-text
        nvim-dap-python
        nvim-dap-go
        promise-async
        nvim-ufo
        codeium-vim
        alpha-nvim
        auto-session
        # bufferline-nvim
        dressing-nvim
        indent-blankline-nvim
        nui-nvim
        # finecmdline
        nvim-treesitter.withAllGrammars
        lualine-nvim
        nvim-autopairs
        nvim-web-devicons
        nvim-cmp
        nvim-surround
        nvim-lspconfig
        cmp-nvim-lsp
        cmp-buffer
        luasnip
        cmp_luasnip
        friendly-snippets
        lspkind-nvim
        comment-nvim
        nvim-ts-context-commentstring
        plenary-nvim
        neodev-nvim
        telescope-nvim
        todo-comments-nvim
        nvim-tree-lua
        telescope-fzf-native-nvim
        vim-tmux-navigator
        formatter-nvim
        catppuccin-nvim
      ];
      extraConfig = ''
        set noemoji
      '';
      extraLuaConfig = ''
        ${builtins.readFile ./options.lua}
        ${builtins.readFile ./keymaps.lua}
        ${builtins.readFile ./plugins/alpha.lua}
        ${builtins.readFile ./plugins/auto-session.lua}
        ${builtins.readFile ./plugins/autopairs.lua}
        ${builtins.readFile ./plugins/blankline.lua}
        ${builtins.readFile ./plugins/catppuccin.lua}
        ${builtins.readFile ./plugins/cmp.lua}
        ${builtins.readFile ./plugins/codeium.lua}
        ${builtins.readFile ./plugins/cokeline.lua}
        ${builtins.readFile ./plugins/comment.lua}
        ${builtins.readFile ./plugins/formatter.lua}
        ${builtins.readFile ./plugins/lsp.lua}
        ${builtins.readFile ./plugins/lualine.lua}
        ${builtins.readFile ./plugins/noice.lua}
        ${builtins.readFile ./plugins/nvim-dap.lua}
        ${builtins.readFile ./plugins/nvim-tree.lua}
        ${builtins.readFile ./plugins/nvim-ufo.lua}
        ${builtins.readFile ./plugins/telescope.lua}
        ${builtins.readFile ./plugins/todo-comments.lua}
        ${builtins.readFile ./plugins/treesitter.lua}
      '';
    };
  };
}
#require("ibl").setup()
