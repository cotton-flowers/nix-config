{
  inputs,
  lib,
  pkgs,
  ...
}: let
  distribute-mode = keys: lib.lists.flatten (lib.attrsets.mapAttrsToList (mode: binds: lib.attrsets.mapAttrsToList (key: action: {inherit key action mode;}) binds) keys);
in {
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    opts = {
      relativenumber = true;
      shiftwidth = 4;
      scrolloff = 8;
      smartcase = true;
    };
    globals = {mapleader = " ";};
    keymaps = distribute-mode {
      n = {
        "<leader>d" = "\"_d";
        " " = "<Nop>";
        "<c-d>" = "<c-d>zz";
        "<C-u>" = "<c-u>zz";
      };
      i = {
        "jk" = "<esc>";
      };
    };

    plugins = {
      nvim-autopairs.enable = true;
      fugitive.enable = true;
      telescope.enable = true;
      telescope.keymaps = {
        # [f]ind in [p]roject;
        "<leader>fp" = "git_files";
        # [f]ind with [g]rep
        "<leader>fg" = "live_grep";
        # [f]ind [f]iles
        "<leader>ff" = "find_files";
        # [f]ind [b]uffer };
        "<leader>fb" = "buffers";
        };

        lsp = {enable = true;};
        which-key.enable = true;
        commentary.enable = true;
        surround.enable = true;
        treesitter.enable = true;
        treesitter-context.enable = true;
        coq-nvim.enable = true;
        coq-nvim.autoStart = "shut-up";
        coq-nvim.recommendedKeymaps = true;
        mini = {
          enable = true;
          mockDevIcons = true;
          modules.icons = {};
        };
      };
      extraPlugins = with pkgs.vimPlugins; [leap-nvim];
      extraConfigLua = '''';
    };
  }
