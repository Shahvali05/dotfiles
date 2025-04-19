{ config, pkgs, ... }:

{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = ["1.1.1.1"];
  
  time.timeZone = "Europe/Moscow";
  
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  networking.firewall.allowedTCPPorts = [ 8000 ];
}
