vim.g.tabby_server_host = 'http://localhost:8080'

require('tabby').setup({
    suggestion = {
        accept_keymap = "<Tab>",  -- Keymap to accept the suggestion
    }
})
