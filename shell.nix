with import <nixpkgs> {};

mkShell {
  # Задаем NIX_LD_LIBRARY_PATH для поиска библиотек
  NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
    glibc
  ];

  buildInputs = [
    pkgs.python3
    pkgs.python3Packages.debugpy  # Add debugpy here
  ];

  # Задаем NIX_LD для использования динамического загрузчика
  NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";

  # Задаем переменные для окружения
  shellHook = ''
    echo "Using NIX_LD=$NIX_LD"
    echo "Using NIX_LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH"
  '';
}

