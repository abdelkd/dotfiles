{ config, pkgs, ... }:
{
  config = {
    programs.tmux = {
      enable = true;
      sensibleOnTop = true;
      baseIndex = 1;
      clock24 = false;
      historyLimit = 5000;
      keyMode = "emacs";
      mouse = false;
      newSession = true;
      plugins = with pkgs; [  ];
      shell = "${pkgs.zsh}/bin/zsh";
      shortcut = "a";
      terminal = "tmux-256color";
      extraConfig = ''

        unbind %
        bind | split-window -h

        unbind '"'
        bind | split-window -v

        unbind r
        bind r source-file ~/.config/tmux/tmux.conf
      '';
    };
  };

}
