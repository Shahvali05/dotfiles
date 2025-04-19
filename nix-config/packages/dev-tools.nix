{ config, pkgs, ... }:

let
  python-with-my-plugins = pkgs.python312.withPackages (ps: with ps; [
    debugpy
    python-lsp-server
    pylsp-mypy
    mypy
    ruff
  ]);
in
{
  environment.systemPackages = with pkgs; [
    # For neovim (temp)
    bash-language-server
    vscode-langservers-extracted
    python-with-my-plugins
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.eslint

    # Development tools
    # qemu
    android-tools
    inetutils
    gdb
    valgrind
    gnumake
    codeium
    cmake
    python312Packages.pgcli
    qpwgraph
    pom
    nekoray
    simplex-chat-desktop
    typora
    aseprite
    
    # System utilities
    bluez
    libvirt
    gvfs
    ntfs3g
    udisks2
    librsvg
    gdk-pixbuf
    gtk3
    gtk4
    xdg-desktop-portal-gtk
    fuse
    v4l-utils
    openjdk11
    gitlab-runner
    waydroid
    heimdall
    odin
    postgresql
    networkmanagerapplet
    pavucontrol
    pulseaudio
    
    # Programming languages and tools
    black
    pyright
    gopls
    clang-tools
    clang
    lua-language-server
    gcc
    nodejs
    python3
    go
  ];
}
