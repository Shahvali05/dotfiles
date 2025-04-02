{ config, pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;
  
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  environment.systemPackages = with pkgs; [
    # Console tools
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
    logseq
    qbittorrent
    libreoffice
    dbeaver-bin
    evince
    blueman
    rofi
    telegram-desktop
    obsidian
    discord
    wf-recorder
    chromium
    xfce.thunar
    onlyoffice-desktopeditors
  ] ++ [
    # Custom cursor
    (pkgs.stdenv.mkDerivation {
      name = "my-custom-cursor";
      src = /home/laraeter/.icons/Bibata-Modern-Ice.tar.xz;
      installPhase = ''
        mkdir -p $out/share/icons
        tar -xf $src -C $out/share/icons
      '';
    })
  ];
}
