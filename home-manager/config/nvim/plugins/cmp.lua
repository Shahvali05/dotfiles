local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- Настройка vim-dadbod
vim.g.db_ui_auto_execute_table_helpers = 1
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_save_location = '~/.config/nvim/db_ui'

-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  completion = {
    completeopt = "menu,menuone,preview,noselect",
  },
  snippet = { -- configure how nvim-cmp interacts with snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
    ["<C-j>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
  -- sources for autocompletion
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- language servers
    { name = "luasnip" }, -- snippets
    { name = "buffer" }, -- text within current buffer
    { name = "path" }, -- file system paths
    { name = 'vim-dadbod-completion' }
  }),

  -- configure lspkind for vs-code like pictograms in completion menu
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.tpp",
  command = "setfiletype cpp",
})
