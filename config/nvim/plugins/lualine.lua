local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic", "coc" },
	sections = { "error", "warn" },
	symbols = { error = "err: ", warn = "warn: " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
	fmt = function(str)
		return "(" .. str .. ")"
	end,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = '* ', modified = '+ ', removed = '~ ' }, -- changes diff symbols
}

local mode = {
	"mode",
	fmt = function(str)
		return "--"..str.."--"  
	end,
}

local filetype = {
	"filetype",
	icons_enabled = false,
	icon = nil,
	fmt = function (str)
		if not (str == nil or str == "") then
			if not (str == "markdown") then
				return "(." .. str .. " file)"
			else
				return "(.md file)"
			end
		else
			return "(Open a file with \":e\")"
		end
	end,
}

local branch = {
	"branch",
	icons_enabled = false,
	fmt = function(str)
		if (str == nil or str == "") then
			return "*"..str
		else
			return "Git:"..str
		end
	end,
}

local location = {
	"location",
	fmt = function(str)
		return "@:" .. str
	end,
}

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local function starts_with(str, start)
	return str:sub(1, #start) == start
end

local filename = {
	"filename",
	symbols = {
		modified = "*",
		readonly = "!",
		unnamed = "n",
		newfile = "+",
	},
	path = 1,
	fmt = function(str)
		if not (str == "n") then
			if not (starts_with(str, "~\\")) then
				return "[~\\"..str.."]"
			else
				return "["..str.."]"
			end
		else
			return "[No Name]";
		end
	end,
}

local fileformat = {
	"fileformat",
	symbols = {
		unix = "Unix (LF)",
		dos = "Windows (CRLF)",
		mac = "Unix (LF)",
	},
	fmt = function(str)
		return "*"..str.."*"
	end,
}

local progress = {
	"progress",
	fmt = function(str)
		if not (str == "Top" or str == "Bot") then
			return "("..str..")"
		else
			if (str == "Bot") then
				return "(EOF / End Of File)"
			elseif (str == "Top") then
				return "(BOF / Beggining Of File)"
			end
		end
	end,
}

local encoding = {
	"encoding",
	fmt = function(str)
		return "(" .. string.upper(str) .. ")"
	end,
}

--[[ local buffers = {
	"buffers",
	mode = 0,
	show_modified_status = false,
	fmt = function(str)
		return "*"..str.."*"
	symbols = {
		modified = '*'
	}
} ]]

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		globalstatus = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { branch },
		lualine_b = { mode },
		lualine_c = { filename, filetype, progress },
		lualine_x = { diagnostics },
		lualine_y = { spaces, encoding, fileformat },
		-- lualine_y = {},
		lualine_z = { location },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
