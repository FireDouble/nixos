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
            nix = {
              enable = true;
              lsp.enable = true;
              format.enable = true;
              extraDiagnostics.enable = true;
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
          utility.motion.precognition.enable = true;

          keymaps = [
            {
              key = "m";
              mode = ["n"];
              action = ":Telescope find_files<CR>";
            }
            {
              key = "<C-m>";
              mode = ["n"];
              action = ":Neotree<CR>";
            }
            {
              key = "M";
              mode = ["n"];
              action = ":Neotree close<CR>";
            }
          ];

          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
          };

          statusline.lualine.enable = true;
        };
      };
    };
  };
}
