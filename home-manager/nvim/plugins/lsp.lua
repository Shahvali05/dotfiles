local lspconfig = require('lspconfig')

-- ============================================================================
-- Основные конфигурации LSP
-- ============================================================================

local configs = {
  -- Функция для привязки клавиш и настройки буфера при подключении LSP
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)

    -- Форматирование через внешние форматтеры (например, black для Python)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        local filetype = vim.bo[bufnr].filetype
        if filetype == "python" then
          -- Используем black для форматирования Python
          vim.fn.system({ "black", "--quiet", vim.api.nvim_buf_get_name(bufnr) })
          vim.api.nvim_buf_call(bufnr, function()
            vim.cmd("edit!") -- Перезагружаем буфер после форматирования
          end)
        elseif client.server_capabilities.documentFormattingProvider then
          -- Асинхронное форматирование для других языков
          vim.lsp.buf.format({ async = true })
        end
      end,
    })
  end,

  -- Настройка возможностей автодополнения
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

-- ============================================================================
-- Конфигурация LSP серверов
-- ============================================================================

-- Определяем путь к Python
local venv_path = os.getenv('VIRTUAL_ENV')
local py_path = venv_path and (venv_path .. "/bin/python3") or vim.g.python3_host_prog

-- Автозапуск bash-language-server для shell-скриптов
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start({
      name = 'bash-language-server',
      cmd = { 'bash-language-server', 'start' },
    })
  end,
})

-- Устанавливаем filetype для файлов .jf
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.jf",
  callback = function()
    vim.bo.filetype = "json"
  end,
})

local lsp_servers = {
  ruff = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('.git', 'pyproject.toml', 'setup.py') or vim.fn.getcwd(),
    }
  },

  basedpyright = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      settings = {
        python = {
          analysis = {
            diagnosticMode = "openFilesOnly",   -- только открытые файлы
            diagnosticUpdateMode = "save",      -- проверять только при сохранении
          },
        },
      },
    }
  },

  jsonls = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      settings = {
        json = {
          validate = { enable = true },
          schemas = require('schemastore').json.schemas(),
          schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
        },
      },
    },
  },

  ts_ls = {
    setup = {
      on_attach = function(client, bufnr)
        -- Отключаем форматирование для ts_ls
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        configs.on_attach(client, bufnr)
      end,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('package.json', '.git') or vim.fn.getcwd(),
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    }
  },

  eslint = {
    setup = {
      on_attach = function(client, bufnr)
        configs.on_attach(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
      end,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('.eslintrc', '.eslintrc.js', '.eslintrc.json', 'package.json') or vim.fn.getcwd(),
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      settings = {
        format = { enable = true },
        lint = { enable = true },
      },
    }
  },

  html = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('package.json', '.git') or vim.fn.getcwd(),
      filetypes = { "html" },
      init_options = {
        provideFormatter = true,
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
          css = true,
          javascript = true
        }
      }
    }
  },

  gopls = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('go.mod', '.git') or vim.fn.getcwd(),
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
          gofumpt = true, -- Для строгого форматирования
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    },
  },

  clangd = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('.git', 'compile_commands.json', 'build') or vim.fn.getcwd(),
      filetypes = { "c", "cpp", "objc", "objcpp" },
      cmd = { "clangd", "--background-index", "--suggest-missing-includes", "--clang-tidy" },
      settings = {
        clangd = {
          fallbackFlags = { "-std=c++17" }, -- Флаги по умолчанию для C++17
        },
      },
    },
  },
}

-- ============================================================================
-- Инициализация настроек LSP
-- ============================================================================

local function setup()
  -- Настройка LSP серверов
  -- lspconfig.ruff.setup(lsp_servers.ruff.setup)
  lspconfig.basedpyright.setup(lsp_servers.basedpyright.setup)
  lspconfig.jsonls.setup(lsp_servers.jsonls.setup)
  lspconfig.ts_ls.setup(lsp_servers.ts_ls.setup)
  lspconfig.eslint.setup(lsp_servers.eslint.setup)
  lspconfig.html.setup(lsp_servers.html.setup)
  lspconfig.gopls.setup(lsp_servers.gopls.setup)
  lspconfig.clangd.setup(lsp_servers.clangd.setup)

  -- Настройка отображения диагностики
  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })
end

-- Запуск конфигурации
setup()
