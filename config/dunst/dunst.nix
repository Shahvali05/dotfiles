{ pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Настройка dunst
  home.packages = with pkgs; [
    dunst
  ];

  home.file.".config/dunst/dunstrc".text = ''
    [global]
    font = monospace 10
    geometry = 300x50-10+10
    transparency = 0.8
    show_age_threshold = 60
    notification_limit = 5
    frame_color = "#323232"
    foreground = "#FFFFFF"
    background = "#1E1E1E"

    [urgency_low]
    timeout = 5
    background = "#2E2E2E"
    foreground = "#FFFFFF"
    frame_color = "#2E2E2E"

    [urgency_normal]
    timeout = 10
    background = "#1E1E1E"
    foreground = "#FFFFFF"
    frame_color = "#323232"

    [urgency_critical]
    timeout = 0
    background = "#FF0000"
    foreground = "#FFFFFF"
    frame_color = "#FF0000"
  '';

  # Дополнительные параметры запуска dunst
  home.sessionVariables = {
    DUNST_CONFIG = "${pkgs.writeTextFile { name = "dunstrc"; text = builtins.readFile ./path-to-your-dunstrc; }}";
  };

  # Запуск dunst при старте
  home.activation.init = ''
    if ! pgrep -x "dunst" > /dev/null; then
      dunst &
    fi
  '';
}

