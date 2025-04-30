{
  description = "My NixOS configuration with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    config.allowBroken = true;
    config.allowUnfree = true;
  in {
    packages.${system} = {
      dwl = pkgs.stdenv.mkDerivation {
        pname = "dwl";
        version = "git";

        src = pkgs.fetchFromGitHub {
          owner = "djpohly";
          repo = "dwl";
          rev = "main"; # Можно конкретный коммит сюда поставить для стабильности
          sha256 = "0000000000000000000000000000000000000000000000000000"; # Поставим правильно ниже
        };

        nativeBuildInputs = with pkgs; [ pkg-config ];
        buildInputs = with pkgs; [ wayland libxkbcommon wlroots ];

        configurePhase = ''
          cp ${./dwl-config.h} config.h
        '';

        installPhase = ''
          mkdir -p $out/bin
          make
          cp dwl $out/bin/
        '';
      };
    };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      # specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.laraeter = import ./home-manager/home.nix;
        }
      ];
    };
  };
}
