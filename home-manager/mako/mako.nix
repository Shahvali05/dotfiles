{ pkgs, inputs, ... }:

{
  services.mako = {
    enable = true;  # включает mako (устанавливает пакет и запускает daemon)
    settings = {
      ignore-timeout = false;
      default-timeout = 5000;
      border-radius = 0;
      text-color = "#FFFFFFFF";
      background-color = "#445577CC";
      anchor = "bottom-right";
    };
  };
}
