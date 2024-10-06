-- default settings
require("lsp-endhints").setup {
	icons = {
		type = "󰜁 ",
		parameter = "󰏪 ",
		offspec = " ", -- hint kind not defined in official LSP spec
		unknown = " ", -- hint kind is nil
	},
	label = {
		padding = 1,
		marginLeft = 0,
		bracketedParameters = true,
	},
	autoEnableHints = true,
}

-- inlay hints will show at the end of the line (default)
require("lsp-endhints").enable()

-- inlay hints will show as if the plugin was not installed
require("lsp-endhints").disable()

-- toggle between the two
require("lsp-endhints").toggle()

-- lua-ls
require("lspconfig").lua_ls.setup {
	settings = {
		Lua = {
			hint = { enable = true },
		},
	},
}

-- tsserver
local inlayHints = {
	includeInlayParameterNameHints = "all",
	includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = false,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayEnumMemberValueHints = true,
}
require("lspconfig").tsserver.setup {
	settings = {
		typescript = {
			inlayHints = inlayHints,
		},
		javascript = {
			inlayHints = inlayHints,
		},
	},
}

-- gopls
require("lspconfig").gopls.setup {
	settings = {
		hints = {
			rangeVariableTypes = true,
			parameterNames = true,
			constantValues = true,
			assignVariableTypes = true,
			compositeLiteralFields = true,
			compositeLiteralTypes = true,
			functionTypeParameters = true,
		},
	},
}

-- clangd
require("lspconfig").clangd.setup {
	settings = {
		clangd = {
			InlayHints = {
				Designators = true,
				Enabled = true,
				ParameterNames = true,
				DeducedTypes = true,
			},
			fallbackFlags = { "-std=c++20" },
		},
	},
}
