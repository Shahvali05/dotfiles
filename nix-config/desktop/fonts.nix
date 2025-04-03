{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "DroidSansMono" "FiraCode" ]; })
    font-awesome
    liberation_ttf
    noto-fonts-cjk
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
