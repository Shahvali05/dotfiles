{ config, pkgs, ... }:

let
  python-with-my-plugins = pkgs.python312.withPackages (ps: with ps; [
    python-lsp-server
    pylsp-mypy
    mypy
  ]);
in
{
  environment.systemPackages = with pkgs; [
    # For neovim (temp)
    bash-language-server
    python-with-my-plugins
    ruff

    # Development tools
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
    gvfs
    ntfs3g
    udisks2
    librsvg
    gdk-pixbuf
    gtk3
    gtk4
    xdg-desktop-portal-gtk
    fuse
    ffmpeg
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
