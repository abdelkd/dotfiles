{ config, pkgs, ... }:
{
  config = {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;
      };
    };
}
