{
  inputs = let version = "25.05"; in {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-${version}";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-${version}";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    #this is where you add flakes
    hardware.url = "github:nixos/nixos-hardware";

    nixvim = {
	url = "github:nix-community/nixvim/nixos-${version}";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#laptop'
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [./nixos/configuration.nix];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#cotton@laptop'
    homeConfigurations = rec {
      "cotton@laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [
	./home-manager/home.nix
		];
      };
    };
  };
}
