{ config, pkgs, lib, ... }:
{
  config.programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    dotDir = ".config/zsh";
    dirHashes = {
      dl = "$HOME/Downloads";
    };
    envExtra = "";
    history = {
      path = "$ZDOTDIR/.zsh_history";
      size = 10000;
      ignoreDups = true;
    };
    historySubstringSearch = {
      enable = true;
    };
    initExtra = ''
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
    '';
    localVariables = {};
    plugins = [
      {
        name = "zsh-autosuggestions";
	      src = pkgs.fetchFromGitHub {
      	  owner = "zsh-users";
      	  repo = "zsh-autosuggestions";
      	  rev = "v0.7.0";
      	  sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
	      };
      }
      {
        name = "zsh-fzf-history-search";
        src = pkgs.fetchFromGitHub {
          owner = "joshskidmore";
          repo = "zsh-fzf-history-search";
          rev = "d1aae98ccd6ce153c97a5401d79fd36418cd2958";
          sha256 = "sha256-6qQzoDlC9/bz26eStaLmI0SvM/9a6u9XbCYzEjVShx4=";
        };
      }

      # {
      #   name = "zoxide";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "ajeetdsouza";
      #     repo = "zoxide";
      #     rev = "fa1cfb490db7e2326a0869a8dbaad61334442eaa";
      #     sha256 = "sha256-6qQzoDlC9/bz26eStaLmI0SvM/9a6u9XbCYzEjVShx4=";
      #   };
      # }

    ];

    sessionVariables = {
        "PNPM_HOME" = "home/kareem/.local/share/pnpm";
      };
    shellAliases = {
      # rbw
      "rbwl" = "rbw get $(rbw ls | fzf)";
      "rbwg" = "rbw get $(rbw ls | fzf) | xclip -sel clip";
      "rbwgu" = "rbw get $(rbw ls | fzf) --field=Username | cut -d':' -d' ' -f2 | xclip -sel clip";
    };

  }; 


}
