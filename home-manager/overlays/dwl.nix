self: super: {
  dwl = super.dwl.overrideAttrs (old: rec {
    pname = "dwl";
    version = "0.7";

    # Локальный исходник dwl 0.7 (можно скачать и положить в ./dwl-0.7)
    src = ./dwl;

    # Добавляем твои патчи
    patches = (old.patches or []) ++ [
      ./dwl-patches/patches/bar/bar-0.7.patch
    ];

    # buildInputs, чтобы nix видел все нужные библиотеки
    buildInputs = (old.buildInputs or []) ++ [
      super.fcft
      super.libdrm
      super.pixman
      super.pango
    ];

    # config.h
    postPatch = ''
      cp ${./dwl/config.h} config.h
    '';
  });
}
