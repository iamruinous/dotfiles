# loud or quiet?
set-option -g visual-activity off
set-option -g visual-bell off
set-option -g visual-silence off
set-window-option -g monitor-activity on
set-option -g bell-action none

set -g base-index 1
set-window-option -g pane-base-index 1
set -g default-terminal "screen-256color"
#set-option -ga terminal-overrides ",*256col*:RGB"
set -as terminal-features ",xterm-256color:RGB"

bind R \
  move-window -r\; \
  display-message "Windows reordered..."

bind -n S-PPage copy-mode -u
bind -T copy-mode S-PPage send -X page-up
bind -T copy-mode S-NPage send -X page-down
