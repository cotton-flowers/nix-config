{inputs, lib, pkgs, ...} : {
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
    globals = { };
    maps = {
	normal = {
	    "<leader>d" = "\"_d";
	    " " = "<Nop>";
	    "<c-d>" = "<c-d>zz";
	    "<C-u>" = "c-u>zz";
	};
	insert = { "jk" = "<esc>";
	};
    };

    plugins = {
	nvim-autopairs.enable = true;
	fugitive.enable   = true;
	telescope.enable  = true;

	telescope.keymaps = {
	    # [f]ind in [p]roject;
	    "<leader>fp" = "git_files";
	    # [f]ind with [g]rep
	    "<leader>fg" = "live_grep";
	    # [f]ind [f]iles
	    "<leader>ff" = "find_files";
	    # [f]ind [b]uffer };
	    "<leader>fb" = "buffers";

	harpoon =  {
	    enable  = true;
	    keymaps = {
		addFile         = "<leader>ha";
		# [h]arpoon [a]dd toggleQuickMenu = "<leader>ht";
		# [h]arpoon [t]abs };
	    };
	lsp = { enable = true; };
	which-key.enable = true;
	commentary.enable = true;
	surround.enable = true;
	treesitter.enable = true;
	treesitter-context.enable = true;
	coq-nvim.enable = true;
	coq-nvim.autoStart = "shut-up";
	coq-nvim.recommendedKeymaps = true;
    };

    extraPlugins = with pkgs.vimPlugins; [ leap-nvim ];
    extraConfigLua = '' '';
    };
}
