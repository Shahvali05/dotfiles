{ config, pkgs, ... }:

let
  pkgs2411 = let
    nixpkgsSrc = builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/nixos-24.11.tar.gz";
      sha256 = "sha256-kNf+obkpJZWar7HZymXZbW+Rlk3HTEIMlpc6FCNz0Ds";
    };
  in import nixpkgsSrc { config = config.nixpkgs.config; };
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
