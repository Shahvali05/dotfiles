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

    -- Автоформат при сохранении
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
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

  pyright = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('.git', 'pyproject.toml', 'setup.py') or vim.fn.getcwd(),
      settings = {
        pyright = {
          disableOrganizeImports = true, -- Ruff сам сортирует импорты
          disableTaggedHints = true, -- Отключаем подсказки для аннотаций
        },
        python = {
          analysis = {
            ignore = { '*' }, -- Игнорируем все правила линтера Pyright
            typeCheckingMode = "basic", -- "off", "basic", "strict"
            diagnosticMode = "openFilesOnly", -- Проверять только открытые файлы
            pythonPath = py_path, -- Указываем путь к интерпретатору Python
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

  ts_ls = { -- Заменяем tsserver на ts_ls
    setup = {
      on_attach = configs.on_attach,
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
}


-- ============================================================================
-- Инициализация настроек LSP
-- ============================================================================


local function setup()
  -- Настройка LSP серверов
  lspconfig.ruff.setup(lsp_servers.ruff.setup)
  lspconfig.pyright.setup(lsp_servers.pyright.setup)
  lspconfig.jsonls.setup(lsp_servers.jsonls.setup)
  lspconfig.ts_ls.setup(lsp_servers.ts_ls.setup)
  lspconfig.eslint.setup(lsp_servers.eslint.setup)
  lspconfig.html.setup(lsp_servers.html.setup)
  lspconfig.gopls.setup(lsp_servers.gopls.setup)

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
