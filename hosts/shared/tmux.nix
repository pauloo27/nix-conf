{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    extraConfig = ''
# make color and stuff work
set -g default-terminal 'tmux-256color'
set -as terminal-overrides ",alacritty*:Tc"

# mouse!
set -g mouse on

# Ctrl-a as "leader" key
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Disable the delay when pressing <Esc> (i use vim, so this is important)
set -s escape-time 0

# use 1 as the first window number
set -g base-index 1

# keybinds
bind r source-file ~/.config/tmux/tmux.conf
bind s split-window -v -c "#{pane_current_path}"
bind v split-window -h -c "#{pane_current_path}"

# bar
set -g status-style 'fg=#908caa'
set -g status-left '   #S | '
set -g status-right ' #(whoami)@#H '

# vim-like visual mode
bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

# nvim <-> tmux
is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?\.?(view|n?vim?x?)(-wrapped)?(diff)?$'"

bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' { if -F '#{pane_at_left}' ''' 'select-pane -L' }
bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' { if -F '#{pane_at_bottom}' ''' 'select-pane -D' }
bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' { if -F '#{pane_at_top}' ''' 'select-pane -U' }
bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' { if -F '#{pane_at_right}' ''' 'select-pane -R' }

bind-key -T copy-mode-vi 'C-h' if -F '#{pane_at_left}' ''' 'select-pane -L'
bind-key -T copy-mode-vi 'C-j' if -F '#{pane_at_bottom}' ''' 'select-pane -D'
bind-key -T copy-mode-vi 'C-k' if -F '#{pane_at_top}' ''' 'select-pane -U'
bind-key -T copy-mode-vi 'C-l' if -F '#{pane_at_right}' ''' 'select-pane -R'
    '';
  };
}
