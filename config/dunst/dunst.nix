{ pkgs, inputs, ... }:

{
  programs.dunst = {
    enable = true;
    settings = {
      font = "monospace 10";
      geometry = "300x50-10+10";
      transparency = 0.8;
      show_age_threshold = 60;
      notification_limit = 5;
      frame_color = "#323232";
      foreground = "#FFFFFF";
      background = "#1E1E1E";
    };
  };
}
