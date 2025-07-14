{ config, pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    # "electron-27.3.11"
  ];

  environment.systemPackages = with pkgs; let
    steamEnv = buildEnv {
      name = "steam-env";
      paths = [
        steam
        steam-run
        mesa
        vulkan-loader
        vulkan-tools
        libva
        gamescope
      ];
    };
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
    steamEnv
    lmstudio
    clapper
    alacritty
    heroic
    gnome-software
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
