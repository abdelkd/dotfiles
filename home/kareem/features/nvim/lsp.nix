{ inputs, pkgs, ... }:
let
  mason-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "mason";
    version = "2023-03-30";
    src = pkgs.fetchFromGitHub {
      owner = "williamboman";
      repo = "mason.nvim";
      rev = "5e059a03b2273d918e9742d38e5e1cb37c2239f2";
      sha256 = "DFmajWrSvsHi3Ug2dwnoKoTyLNOfZ6XJY3YdrzrZC3c=";
      };
    };
  lspsaga = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "lspsaga";
    version = "2023-03-29";
    src = pkgs.fetchFromGitHub {
      owner = "glepnir";
      repo = "lspsaga.nvim";
      rev = "abb0e427ffd70cb5b240f17d996b7c84cd55d001";
      sha256 = "tcvpDHGFV7elpy8af/EOsIRyvaqEqLTF/dEWCTSBaSY=";
      };
    };
  mason-lspconfig = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "mason-lspconfig";
    version = "2023-03-24";
    src = pkgs.fetchFromGitHub {
      owner = "williamboman";
      repo = "mason-lspconfig.nvim";
      rev = "b64fdede85fd5e0b720ce722919e0a9b95ed6547";
      sha256 = "ZG00ZNvKSFFuXFZPUDbtC2LtXN+xGfzayw1Uxi0Iwio=";
      };
    };
  mason-null-ls = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "mason-null-ls";
    version = "2023-03-27";
    src = pkgs.fetchFromGitHub {
      owner = "jay-babu";
      repo = "mason-null-ls.nvim";
      rev = "a991e7697514f30126fac7c07a11c488c553e94f";
      sha256 = "Ml3gGlnqKlqyNL5eVg/1AuE4x00bH2U7tW99C8LAtMM=";
    };
  };
  typescript-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "typescript-nvim";
      version = "2023-01-03";
      src = pkgs.fetchFromGitHub {
          owner = "jose-elias-alvarez";
          repo = "typescript.nvim";
          rev = "f66d4472606cb24615dfb7dbc6557e779d177624";
          sha256 = "PHVY5NJbOGvY9p0F0QNSfMKmAWdqjw1RB0Vspq88qMI=";
        };
  };
in
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
      # LSP
      mason-nvim
      mason-lspconfig

      nvim-lspconfig 
      cmp-nvim-lsp
      lspsaga
      typescript-nvim
      lspkind-nvim
      go-nvim
      
      # formatting & linting
      null-ls-nvim
      mason-null-ls


      # language specific lsps
      rust-vim

  ];

  home.packages = with pkgs; [
    lua-language-server
    stylua
    rust-analyzer
    gopls
    clang-tools_16

    nodePackages.eslint_d
    nodePackages.prettier
  ];
}
