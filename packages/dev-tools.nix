{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Development tools
    mysql-workbench
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
    python314
    go
  ];
}
