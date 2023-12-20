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
	    discord
	    spotify
	    zathura
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
	    scrolloff = 8;
	    smartcase = true;
	};

	globals = {
	};

	maps = {
	    normal = {
		"<leader>d" = "\"_d";
		" " = "<Nop>";
		"<c-d>" = "<c-d>zz";
		"<C-u>" = "c-u>zz";
	    };

	    insert = {
		"jk" = "<esc>";
	    };
	};

	colorschemes.gruvbox.enable = true;

	plugins = {
	    fugitive.enable   = true;
	    telescope.enable  = true;
	    telescope.keymaps = {
	      "<leader>fp" = "git_files";  # [f]ind in [p]roject; 
	      "<leader>fg" = "live_grep";  # [f]ind with [g]rep
	      "<leader>ff" = "find_files"; # [f]ind [f]iles
	      "<leader>fb" = "buffers";    # [f]ind [b]uffer
	      };

	    harpoon =  {
		enable  = true;
		keymaps = {
		    addFile         = "<leader>ha";
		    toggleQuickMenu = "<leader>ht";
		};


	    };

	    which-key.enable = true;
	    commentary.enable = true;
	    surround.enable = true;

	    lsp.enable = true;

	    treesitter.enable = true;
	    treesitter.folding = true;    
	    treesitter-context.enable = true;

	    coq-nvim.enable = true;
	    coq-nvim.autoStart = "shut-up";
	    coq-nvim.recommendedKeymaps = true;

	    neorg =  {
		enable   = true;
		modules = {
		    "core.defaults" = {__empty = null;};
		    "core.dirman" = {
			config = {
			    workspaces = {
				notes = "~/notes";
			    };
			    default_workspace = "notes";
			};
		    };
		};
	    };
	};

	extraPlugins = with pkgs.vimPlugins; [
	    lightspeed-nvim
	];

	extraConfigLua = ''
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
