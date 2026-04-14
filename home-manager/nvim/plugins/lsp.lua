-- ============================================================================
-- Общие настройки
-- ============================================================================

local configs = {}

configs.capabilities = require("cmp_nvim_lsp").default_capabilities()

configs.on_attach = function(client, bufnr)
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>lc", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, bufopts)

  -- Отключаем форматирование у basedpyright
  if client.name == "basedpyright" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  -- Отключаем форматирование у ts_ls (его будет делать eslint)
  if client.name == "ts_ls" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  -- Буферная команда :Format
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
    local ft = vim.bo[bufnr].filetype
    local ts_family = { "typescript", "typescriptreact", "javascript", "javascriptreact" }

    if ft == "python" then
      local fname = vim.api.nvim_buf_get_name(bufnr)
      if fname == "" then
        vim.notify("Buffer has no name, can't run black.", vim.log.levels.ERROR)
        return
      end

      vim.cmd("write")
      vim.fn.system({ "black", "--quiet", fname })

      if vim.v.shell_error == 0 then
        vim.cmd("edit")
        vim.notify("Black formatted " .. fname)
      else
        vim.notify("Black failed.", vim.log.levels.ERROR)
      end
    elseif vim.tbl_contains(ts_family, ft) then
      -- Вызываем eslint вместо ts_ls
      vim.lsp.buf.format({ 
        name = "eslint", 
        bufnr = bufnr,
        async = false,
      })
    else
      vim.lsp.buf.format({ bufnr = bufnr })
    end
  end, { desc = "Format buffer" })
end

-- ============================================================================
-- Python
-- ============================================================================

-- Ruff (lint)
vim.lsp.config("ruff", {
  on_attach = configs.on_attach,
  capabilities = configs.capabilities,
  root_markers = { ".git", "pyproject.toml", "setup.py" },
})
vim.lsp.enable("ruff")

-- BasedPyright (type checking)
vim.lsp.config("basedpyright", {
  on_attach = configs.on_attach,
  capabilities = configs.capabilities,
  settings = {
    python = {
      analysis = {
        diagnosticMode = "openFilesOnly",
        diagnosticUpdateMode = "save",
        typeCheckingMode = "basic",
      },
    },
  },
})
vim.lsp.enable("basedpyright")

-- ============================================================================
-- Web
-- ============================================================================

-- TypeScript (только LSP, форматирование отключено в on_attach)
vim.lsp.config("ts_ls", {
  on_attach = configs.on_attach,
  capabilities = configs.capabilities,
  root_markers = { "package.json", ".git" },
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
})
vim.lsp.enable("ts_ls")

-- ESLint (lint + форматирование)
vim.lsp.config("eslint", {
  on_attach = configs.on_attach,
  capabilities = configs.capabilities,

  settings = {
    format = { enable = true }, -- Включаем форматирование через eslint
  },

  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },

  root_markers = {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.json",
    "package.json",
  },
})
vim.lsp.enable("eslint")

-- HTML
vim.lsp.config("html", {
  on_attach = configs.on_attach,
  capabilities = configs.capabilities,
})
vim.lsp.enable("html")

-- JSON
vim.lsp.config("jsonls", {
  on_attach = configs.on_attach,
  capabilities = configs.capabilities,
  settings = {
    json = {
      validate = { enable = true },
      schemas = require("schemastore").json.schemas(),
    },
  },
})
vim.lsp.enable("jsonls")

-- Bash
vim.lsp.config("bashls", {
  on_attach = configs.on_attach,
  capabilities = configs.capabilities,
})
vim.lsp.enable("bashls")

-- ============================================================================
-- Go
-- ============================================================================

vim.lsp.config("gopls", {
  on_attach = configs.on_attach,
  capabilities = configs.capabilities,
  root_markers = { "go.mod", ".git" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})
vim.lsp.enable("gopls")

-- ============================================================================
-- C / C++
-- ============================================================================

vim.lsp.config("clangd", {
  on_attach = configs.on_attach,
  capabilities = configs.capabilities,
  cmd = { "clangd", "--background-index", "--clang-tidy" },
  root_markers = { ".git", "compile_commands.json", "build" },
})
vim.lsp.enable("clangd")

-- ============================================================================
-- Vue 
-- ============================================================================

vim.lsp.config("vue_ls", {
  on_attach = configs.on_attach,
  capabilities = configs.capabilities,
  filetypes = { "vue" },
  root_markers = {
    "package.json",
    "vue.config.js",
    "vite.config.js",
    ".git",
  },
})
vim.lsp.enable("vue_ls")

-- ============================================================================
-- Диагностика
-- ============================================================================

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- ============================================================================
-- Глобальный :Format
-- ============================================================================

vim.api.nvim_create_user_command("Format", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.bo[bufnr].filetype

  if ft == "python" then
    local fname = vim.api.nvim_buf_get_name(bufnr)
    vim.cmd("write")
    vim.fn.system({ "black", "--quiet", fname })
    if vim.v.shell_error == 0 then
      vim.cmd("edit")
      vim.notify("Black formatted " .. fname)
    else
      vim.notify("Black failed.", vim.log.levels.ERROR)
    end
  elseif ft == "typescript" or ft == "typescriptreact"
      or ft == "javascript" or ft == "javascriptreact" then
    -- Вызываем eslint вместо ts_ls
    vim.lsp.buf.format({ name = "eslint", bufnr = bufnr })
  else
    vim.lsp.buf.format({ bufnr = bufnr })
  end
end, { desc = "Format buffer" })
