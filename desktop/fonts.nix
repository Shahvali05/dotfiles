{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.JetBrainsMono
    pkgs.nerd-fonts.DroidSansMono
    pkgs.nerd-fonts.FiraCode
    # (nerdfonts.override { fonts = [ "JetBrainsMono" "DroidSansMono" "FiraCode" ]; })
    font-awesome
    liberation_ttf
    noto-fonts-cjk-sans
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Liberation Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "JetBrains Mono" "Fira Code" ];
    };
  };
}

