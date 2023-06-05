{ inputs, config, pkgs, lib, ...  }:
let
  fetchFromGitHub = pkgs.fetchFromGitHub;
  nvim-vtsls = pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "nvim-vtsls";
      version = "2023-06-02";
      src = pkgs.fetchFromGitHub {
          owner = "yioneko";
          repo = "nvim-vtsls";
          rev = "a8b50c725bacbadd8c50bf966a0427ab2d39f62b";
          sha256 = "sha256-L6FG52uWvxE7AFs84PHaq0x/rm/h0Jm2+nF2tqUPw2w=";
      };
  };
  vim-maximizer = pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "vim-maximizer";
      version = "2015";
      src = pkgs.fetchFromGitHub {
          owner = "szw";
          repo = "vim-maximizer";
          rev = "2e54952fe91e140a2e69f35f22131219fcd9c5f1";
          sha256 = "sha256-+VPcMn4NuxLRpY1nXz7APaXlRQVZD3Y7SprB/hvNKww=";
      };
  };
  todo-comments = pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "todo-comments.nvim";
      version = "2023-03-31";
      src = pkgs.fetchFromGitHub {
        owner = "folke";
        repo = "todo-comments.nvim";
        rev = "v1.1.0";
        hash = "sha256-Z4jaklYoU4TU/3UuK1krImqMzU6sNxJM/XWPCnNBuwo=";
      };
  };
in
{
  # TODO
  imports = [ ./lsp.nix ];
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    
    extraConfig = ''     
      ${builtins.readFile ./init.vim}
    '';
    extraLuaConfig = ''
      ${builtins.readFile ./set.lua}
      ${builtins.readFile ./remap.lua}
      ${builtins.readFile ./plugins.lua}
      ${builtins.readFile ./evil_lualine.lua}
      '';

    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      catppuccin-nvim

      undotree
      # todo-comments
      neoformat
      vim-fugitive
      # vim-tmux-navigator
      vim-maximizer
      vim-surround
      comment-nvim
      plenary-nvim
      nvim-tree-lua
      nvim-web-devicons
      lualine-nvim
      telescope-nvim
      telescope-fzf-native-nvim

      # autocompletion
      nvim-cmp

      # snippets
      friendly-snippets

      vim-startuptime
      nvim-vtsls

      (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins;[ lua markdown nix svelte tsx typescript yaml prisma go ]))
    ];
  };

  

} 
