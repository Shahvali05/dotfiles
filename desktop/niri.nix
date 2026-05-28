{ pkgs, inputs, ... }:
{
  programs.niri = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    niri
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
