{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim = {
	url = "github:nix-community/nixvim/nixos-25.05";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... } @ inputs : {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#laptop'
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        # > Our main nixos configuration file <
        modules = [./nixos/configuration.nix];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#cotton@laptop'
    homeConfigurations = {
      "cotton@laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; 
	 extraSpecialArgs = { inherit inputs; };
        modules = [
	    ./home-manager/home.nix
	];
      };
    };
  };
}
