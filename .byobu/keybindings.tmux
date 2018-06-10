source $BYOBU_PREFIX/share/byobu/keybindings/f-keys.tmux
set -g default-terminal "screen-256color"
set -g prefix C-B
unbind-key -n C-a
set-window-option -g mode-keys emacs
bind-key C-k kill-pane
