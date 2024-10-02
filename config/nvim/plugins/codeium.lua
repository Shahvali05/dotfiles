require'lspconfig'.codeium-vim.setup{
  cmd = { "env", "NIX_LD_x86_64-linux=/nix/store/c10zhkbp6jmyh0xc5kd123ga8yy2p4hk-glibc-2.39-52/lib/ld-linux-x86-64.so.2", "./language_server_linux_x64" },
  -- другие настройки
}

