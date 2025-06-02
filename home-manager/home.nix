# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
    inputs,
    lib,
    config,
    pkgs,
    ...
}: {
    imports = [
	./sway.nix
	./nixvim.nix
    ];

    nixpkgs = {
	overlays = [

	]; config = {
	    allowUnfree = true;
	    # Workaround for https://github.com/nix-community/home-manager/issues/2942
	    allowUnfreePredicate = _: true;
	};
    };

    home = {
	username = "cotton";
	homeDirectory = "/home/cotton";

	packages = with pkgs; [
	    ripgrep
	    discord
	    firefox
#	    spotify
#	    zathura
	    wl-clipboard
#	    ghc
#	    obsidian
	];
    };


# Enable home-manager and git
    programs.home-manager.enable = true;
    programs.git.enable = true;

# Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.05";
}
