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
    # ./nvim.nix
  ];

  nixpkgs = {
    overlays = [

    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };
	
  home = {
    username = "cotton";
    homeDirectory = "/home/cotton";
  };

  programs.nixvim = {
  	enable = true;

	viAlias = true;
	vimAlieas = true;
	vimdiffAlias = true;

	extraPackages = with pkgs; {
		wl-clipboard
	};
	
	
	options = {
		relativenumber = true;
		shiftwidth = 4;
	}

	keymaps = [
#	{
#		mode = "n";
#		key = "<leader>m";
#		options.silent = true;
#		action = "<cmd>!make<CR>";
#	}

	colorschemes.gruvbox.enable = true
	
	plugins = {
		plugins.fugitive.enable = true;
	};

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
