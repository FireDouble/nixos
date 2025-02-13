{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  options = {
    nvf.enable = lib.mkEnableOption "Enable nvf";
  };

  config = lib.mkIf config.nvf.enable {
    programs.nvf = {
      enable = true;
      enableManpages = true;

      settings = {
        vim = {
          lsp = {
            enable = true;
            formatOnSave = true;
          };

          languages = {
            enableTreesitter = true;
            nix = {
              enable = true;
              lsp.enable = true;
              format.enable = true;
            };

            rust = {
              enable = true;
              lsp.enable = true;
            };

            svelte = {
              enable = true;
              lsp.enable = true;
            };

            ts = {
              enable = true;
              lsp.enable = true;
            };
          };

          telescope.enable = true;
          treesitter.enable = true;

          autocomplete.nvim-cmp.enable = true;
          autopairs.nvim-autopairs.enable = true;
          binds.whichKey.enable = true;
          comments.comment-nvim.enable = true;
          filetree.neo-tree.enable = true;
          git.vim-fugitive.enable = true;
          statusline.lualine.enable = true;
          utility.motion.precognition.enable = true;

          keymaps = [
            {
              key = "M";
              mode = ["n"];
              action = ":Telescope find_files<CR>";
            }
            {
              key = "<C-m>";
              mode = ["n"];
              action = ":Neotree toggle<CR>";
            }
          ];

          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
          };

          options = {
            shiftwidth = 4;
            tabstop = 4;
          };

          luaConfigPost = ''
            vim.api.nvim_create_autocmd("FileType", {
              pattern = "nix",
              callback = function(opts)
                local bo = vim.bo[opts.buf]
                bo.tabstop = 2
                bo.shiftwidth = 2
              end
            })
          '';
        };
      };
    };
  };
}
