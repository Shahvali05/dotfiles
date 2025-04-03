{ config, pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;
  
  # nixpkgs.config.permittedInsecurePackages = [
  #   "electron-27.3.11"
  # ];

  environment.systemPackages = with pkgs; [
    # Console tools
    lxappearance
    kitty
    tree
    unzip
    git
    wl-clipboard
    slurp
    grim
    btop
    neovim
    neofetch
    brightnessctl
    killall
    pamixer
    
    # Desktop programs
    github-desktop
    element-desktop
    obs-studio
    keepassxc
    filezilla
    steam
    vscode
    qbittorrent
    libreoffice
    dbeaver-bin
    evince
    blueman
    rofi
    telegram-desktop
    obsidian
    wf-recorder
    chromium
    xfce.thunar
  ];
}
