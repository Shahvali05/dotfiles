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
    evince
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
  ];
}
