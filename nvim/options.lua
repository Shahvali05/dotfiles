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
vim.cmd("highlight ColorColumn ctermbg=red guibg=#232234")

require('ufo').setup()
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

--vim.o.foldmethod = 'indent'
--vim.cmd('autocmd BufReadPost * normal! zR')
