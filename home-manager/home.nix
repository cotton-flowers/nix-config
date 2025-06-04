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
	./nixvim.nix
	./hypr.nix
	# ./sway.nix
	#./i3.nix
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
	    foot
	    ripgrep
	    discord
	    firefox
	    wl-clipboard
#	    spotify
#	    zathura
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
