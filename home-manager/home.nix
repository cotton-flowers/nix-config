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
	      "<C-p>"      = "git_files";  #desc = "find files in it project"; }; 
	      "<leader>fg" = "live_grep";  #desc = "live grep"; };
	      "<leader>ff" = "find_files"; #desc = "fuzzy find files"; };
	      "<leader>fb" = "buffers";    #desc = "find in buffers"; };
	      };
	    harpoon =  {
		enable  = true;
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

	extraConfigLua = ''
	    vim.g.mapleader = " ";
	    '';
	extraConfigVim = ''
	   let g:mapleader = " " 
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
