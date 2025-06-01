{ config, pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;
  
  nixpkgs.config.permittedInsecurePackages = [
    # "electron-27.3.11"
  ];

  environment.systemPackages = with pkgs; let
    steamFHS = (buildFHSUserEnv {
      name = "steam-fhs";
      targetPkgs = pkgs: with pkgs; [
        steam
        steam-run
        mesa
        vulkan-loader
        vulkan-tools
        libva
        gamescope
      ];
      multiPkgs = pkgs: with pkgs; [
        (pkgsi686Linux.mesa)
        (pkgsi686Linux.vulkan-loader)
        (pkgsi686Linux.libva)
        xorg.libX11
        xorg.libXcursor
        xorg.libXinerama
        xorg.libXrandr
        xorg.libXi
        libGL
        libva
      ];
    }).env;
  in [
    # Console tools
    playerctl
    ffmpeg
    nwg-look
    themechanger
    libsForQt5.qt5ct
    kitty
    tree
    unzip
    git
    wl-clipboard
    slurp
    grim
    btop
    neofetch
    brightnessctl
    killall
    pamixer
    
    # Desktop programs
    steamFHS
    lmstudio
    clapper
    alacritty
    # virt-manager
    zathura
    pomodoro-gtk
    bottles
    gthumb
    github-desktop
    obs-studio
    keepassxc
    filezilla
    vscode
    qbittorrent
    libreoffice
    # blueman
    rofi
    telegram-desktop
    obsidian
    wf-recorder
    chromium
    xfce.thunar
    xfce.thunar-volman
  ];
}
