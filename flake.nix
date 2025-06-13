{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.hostSystem = "x86_64-linux";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixos-wsl,
    nixpkgs,
    home-manager,
    nixvim,
    ...
  } @ inputs: {
    nixosConfigurations = {
      # Available through 'nixos-rebuild --flake .#[host]'
      laptop = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/configuration.nix
          ./nixos/laptop.nix
          ./nixos/wayland.nix
        ];
      };

      desktop = nixpkgs.lib.nixosSystem {
        modules = [
          nixos-wsl.nixosModules.default
          ./nixos/configuration.nix
          ./nixos/wsl.nix
        ];
      };
    };

    # Available through 'home-manager --flake .#cotton@[host]'
    homeConfigurations = {
      "cotton@majalis" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home-manager/home.nix
          ./home-manager/laptop.nix
          ./home-manager/nvim.nix
          ./home-manager/hypr.nix
        ];
      };

      "cotton@carnegiea" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home-manager/home.nix
          ./home-manager/carnegia.nix
          ./home-manager/nvim.nix
        ];
      };
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
