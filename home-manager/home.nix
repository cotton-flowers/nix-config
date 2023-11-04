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
	inputs.nixvim.homeManagerModules.nixvim
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
	    wl-clipboard
	];
    };

    programs.nixvim = {
	enable = true;

	viAlias = true;
	vimAlias = true;

	options = {
	    relativenumber = true;
	    shiftwidth = 4;
	};

	globals = {
	    mapleader = " ";
	};

	maps = {
	    normal = {
		"<leader>d".action = "\"_d";
		" ".action = "<Nop>";
	    };
	};

	colorschemes.gruvbox.enable = true;

	plugins = {
	    fugitive.enable   = true;
	    telescope.enable  = true;
	    telescope.keymaps = {
	      "<C-p>"      = {action = "git_files";  desc = "find files in it project"; }; 
	      "<leader>fg" = {action = "live_grep";  desc = "live grep"; };
	      "<leader>ff" = {action = "find_files"; desc = "fuzzy find files"; };
	      "<leader>fb" = {action = "buffers";    desc = "find in buffers"; };
	      };
	    harpoon =  {
		enable  = true;
		enableTelescope = true;
		keymaps = {
		    addFile         = "<leader>a";
		    toggleQuickMenu = "<leader>t";
		};
	    };
	    which-key.enable  = true;
	    commentary.enable = true;
	    surround.enable   = true;
	    lsp.enable        = true;
	};

	extraPlugins = with pkgs.vimPlugins; [
	    lightspeed-nvim
	];

	extraConfigLua = '''
	    -- Print a little welcome message when nvim is opened!
	    print("Hello world!")
	    '';
    };

# Enable home-manager and git
    programs.home-manager.enable = true;
    programs.git.enable = true;

# Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.05";
}
