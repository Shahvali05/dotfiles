{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-code
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

