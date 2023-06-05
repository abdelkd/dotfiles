{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    baseIndex = 1;
    clock24 = false;
    historyLimit = 5000;
    mouse = true;
    keyMode = "vi";
    newSession = true;
    plugins = with pkgs.tmuxPlugins; [ 
      {
        plugin = catppuccin; # catppuccin theme
        extraConfig = "set -g @catppuccin_flavour 'mocha'";
      }
      {
        plugin = resurrect; # restore tmux environment after system restart
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      {
        plugin = continuum; # continuous saving of tmux environment
        extraConfig = ''
          set -g @continuum-restor 'on'
          set -g @continuum-save-interval '60'
        '';
      }
      # vim-tmux-navigator # seamless navigation between tmux panes and vim splits

    ];
    prefix = "C-a";
    shortcut = "a";
    terminal = "tmux-256color";
    extraConfig = ''
      set -ga terminal-overrides ",st-256color"

      unbind %
      bind | split-window -h

      unbind '"'
      bind - split-window -v

      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5

      bind -r m resize-pane -Z

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection

      unbind -T copy-mode-vi MouseDragEnd1Pane


    '';
  };
}
