{ config, pkgs, ... }:

let
  # Импортируем nixpkgs версии 24.11
  pkgs2411 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/24.11.tar.gz") {};
in
{
  environment.systemPackages = with pkgs; [
    # Development tools
    # qemu
    android-tools
    inetutils
    gdb
    valgrind
    gnumake
    cmake
    python312Packages.pgcli
    qpwgraph
    pom
    pkgs2411.nekoray
    simplex-chat-desktop
    typora
    aseprite
    
    # System utilities
    bridge-utils
    bluez
    libvirt
    gvfs
    # gvfs-fuse
    # fuse3
    ntfs3g
    # udisks2
    # udiskie
    librsvg
    gdk-pixbuf
    gtk3
    gtk4
    hicolor-icon-theme
    xdg-desktop-portal-gtk
    fuse
    v4l-utils
    openjdk11
    gitlab-runner
    # waydroid
    heimdall
    odin
    postgresql
    networkmanagerapplet
    pavucontrol
    pulseaudio
    
    # Programming languages and tools
    gcc
    nodejs
    python3
    go
  ];
}
