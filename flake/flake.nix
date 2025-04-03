{
  description = "NixOS and Home Manager configuration";

  inputs = {
    # Specify the stable source of Nixpkgs.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    
    # Specify the Home Manager input, following nixpkgs.
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    # Define the system architecture
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      in {
      # NixOS system configuration
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        # Pass inputs (nixpkgs, home-manager, etc.) as special arguments
        specialArgs = { inherit inputs; };

        # Define the NixOS modules (configuration.nix)
        modules = [
          ./configuration.nix
        ];
      };

      # Home Manager configuration
      homeConfigurations."laraeter" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Home Manager modules (home.nix)
        modules = [ ./home.nix ];

        # Optionally pass extra arguments to home.nix
        # extraSpecialArgs = {};
      };
    
  };
}
