{ config, pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;
  
  nixpkgs.config.permittedInsecurePackages = [
    # "electron-27.3.11"
  ];

  environment.systemPackages = with pkgs; [
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
    steam
    mesa-demos
    vulkaninfo
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
