vim.g.codeium_language_server = "/run/current-system/sw/bin/codeium_language_server"
vim.defer_fn(function()
    vim.fn['codeium#Start']()
end, 0)
