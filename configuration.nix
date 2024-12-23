# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # -------------------------------------------------------------------------------------------------------------
  # Bootloader.
  # -------------------------------------------------------------------------------------------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # -------------------------------------------------------------------------------------------------------------
  # network
  # -------------------------------------------------------------------------------------------------------------
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # nameservers
  networking.nameservers = ["1.1.1.1"];

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
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

  # -------------------------------------------------------------------------------------------------------------
  # services 
  # -------------------------------------------------------------------------------------------------------------
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # services.flatpak.enable = true;

  security.pam.services.greetd.enableGnomeKeyring = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "us";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.laraeter = {
    isNormalUser = true;
    description = "Shahvali";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # hyprland
  programs.hyprland.enable = true; # enable Hyprland

  # -------------------------------------------------------------------------------------------------------------
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # -------------------------------------------------------------------------------------------------------------
  environment.systemPackages = with pkgs; [
    # -------------------------------------
    # console
    # -------------------------------------
    kitty
    # -------------------------------------
    # console's programs
    # -------------------------------------
    tree
    mysql-workbench
    android-tools
    inetutils
    gdb
    swww
    codeium
    valgrind
    gnumake
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
    # -------------------------------------
    # desktop's programs
    # -------------------------------------
    element-desktop
    elements
    element
    obs-studio
    python312Packages.pgcli
    keepassxc
    filezilla
    qpwgraph
    steam
    cmake
    vscode
    # pomodoro-gtk
    openpomodoro-cli
    nekoray
    logseq
    qbittorrent
    simplex-chat-desktop
    libreoffice
    dbeaver-bin
    evince
    blueman
    rofi
    typora hyprpicker
    telegram-desktop
    obsidian
    swaylock
    aseprite
    discord
    wf-recorder
    wofi
    chromium
    waybar
    xfce.thunar
    # -------------------------------------
    # libs
    # -------------------------------------
    # zlib
    # glibc
    # check
    # gtest
    # -------------------------------------
    # system's programs
    # ------------------------------------- libvpx
    ffmpeg
    v4l-utils
    openjdk11
    gitlab-runner
    waydroid
    heimdall
    odin
    postgresql
    networkmanagerapplet
    pavucontrol
    dbus
    pulseaudio
    black
    pyright
    gopls
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    nwg-look
    libsForQt5.qt5ct
    clang-tools
    clang
    lua-language-server
    gcc
    nodejs
    python3
    go
    greetd.tuigreet
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    (pkgs.stdenv.mkDerivation {
      name = "my-custom-cursor";
      src = /home/laraeter/.icons/Bibata-Modern-Ice.tar.xz;
      installPhase = ''
        mkdir -p $out/share/icons
        tar -xf $src -C $out/share/icons
      '';
    })
  ];

  # -------------------------------------------------------------------------------------------------------------
  # nix-ld
  # -------------------------------------------------------------------------------------------------------------
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
  ];

  # -------------------------------------------------------------------------------------------------------------
  # permittedInsecurePackages
  # -------------------------------------------------------------------------------------------------------------
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  # -------------------------------------------------------------------------------------------------------------
  # theme
  # -------------------------------------------------------------------------------------------------------------

  # -------------------------------------------------------------------------------------------------------------
  # fonts
  # -------------------------------------------------------------------------------------------------------------
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" "DroidSansMono" "FiraCode" ];
    })
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

  # -------------------------------------------------------------------------------------------------------------
  # virtualisation
  # -------------------------------------------------------------------------------------------------------------
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "laraeter" ];

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "laraeter" ];

  programs.adb.enable = true;

  # -------------------------------------------------------------------------------------------------------------
  # SQL
  # -------------------------------------------------------------------------------------------------------------
  services.postgresql = {
    enable = true;

    # package = pkgs.postgresql_16;

    # Указываем имя базы данных, которая будет создана при инициализации.
    ensureDatabases = [ "mydatabase" ];

    # Устанавливаем метод аутентификации. 
    # Здесь `trust` позволит всем локальным пользователям подключаться без пароля.
    # Убедитесь, что это подходит для ваших нужд безопасности.
    authentication = pkgs.lib.mkOverride 10 ''
      # type  database  user  auth-method
      local   all             all                                     trust
      host    all             all             127.0.0.1/32            trust
      host    all             all             ::1/128                 trust
    '';
  };

  services.mysql = {
    enable = true;
    package = pkgs.mysql;  # или pkgs.mariadb, если предпочитаете MariaDB
  };

  # -------------------------------------------------------------------------------------------------------------
  # waydroid
  # -------------------------------------------------------------------------------------------------------------
  # Подключение Waydroid
  virtualisation.waydroid.enable = true;

  # Обеспечение работы OpenGL (графический рендеринг)
  hardware.opengl.enable = true;

  # Подключение модулей ядра, необходимых для Waydroid
  boot.kernelModules = [ "binder_linux" "ashmem_linux" ];

  # Включение поддержки cgroups v1 и v2
  boot.kernelParams = [
    "cgroup_enable=memory"
    "swapaccount=1"
  ];

  # Включение системного сервиса для LXC
  systemd.services.lxcfs.enable = true;

  # Поддержка контейнеров
  virtualisation.lxc.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # -------------------------------------------------------------------------------------------------------------
  # shell
  # -------------------------------------------------------------------------------------------------------------
  programs.fish.enable = true;
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
