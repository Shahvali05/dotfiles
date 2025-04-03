local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
--opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.mouse = "a"
opt.cursorline = true
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
--opt.splitright = true
--opt.splitbelow = true
opt.swapfile = false
vim.g.mapleader = " "

vim.opt.colorcolumn = "81"
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd('highlight ColorColumn ctermbg=red guibg=#232234')
  end,
})

-- Настроить нажатие > в Visual режиме для добавления табуляции
vim.api.nvim_set_keymap('x', '>', '>gv', { noremap = true, silent = true })

-- Настроить нажатие < в Visual режиме для уменьшения отступа
vim.api.nvim_set_keymap('x', '<', '<gv', { noremap = true, silent = true })

--vim.o.foldmethod = 'indent'
--vim.cmd('autocmd BufReadPost * normal! zR')
