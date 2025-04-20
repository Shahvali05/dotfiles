{ config, pkgs, ... }:

{
  services.dbus.enable = true;
  services.printing.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      local   all   all   trust
      host    all   all   127.0.0.1/32   trust
      host    all   all   ::1/128        trust
    '';
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  services.zapret.enable = true;
  services.zapret.config = ''
    FWTYPE=nftables
    SET_MAXELEM=522288
    IPSET_OPT="hashsize 262144 maxelem $SET_MAXELEM"
    IP2NET_OPT4="--prefix-length=22-30 --v4-threshold=3/4"
    IP2NET_OPT6="--prefix-length=56-64 --v6-threshold=5"
    AUTOHOSTLIST_RETRANS_THRESHOLD=3
    AUTOHOSTLIST_FAIL_THRESHOLD=3
    AUTOHOSTLIST_FAIL_TIME=60
    AUTOHOSTLIST_DEBUGLOG=0
    MDIG_THREADS=30

    GZIP_LISTS=1

    MODE=nfqws
    MODE_HTTP=1
    MODE_HTTP_KEEPALIVE=0
    MODE_HTTPS=1
    MODE_QUIC=1
    MODE_FILTER=none

    DESYNC_MARK=0x40000000
    DESYNC_MARK_POSTNAT=0x20000000
    NFQWS_OPT_DESYNC="--dpi-desync=disorder2"
    TPWS_OPT="--hostspell=HOST --split-http-req=method --split-pos=3 --oob"

    FLOWOFFLOAD=donttouch

    INIT_APPLY_FW=1
    DISABLE_IPV6=0
  '';
}
