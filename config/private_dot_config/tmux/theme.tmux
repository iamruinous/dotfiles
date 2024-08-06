#!/usr/bin/env bash

set -g status "on"
set -g status-right-length 150
set -g status-justify left

set -g status-left "#[fg=black,bg=blue,bold]#{?client_prefix,, tmux #[fg=blue,bg=black,nobold,nounderscore,noitalics]}#[fg=black,bg=#41a6b5,bold]#{?client_prefix, tmux 󰘳#[fg=#41a6b5 bg=black nobold nounderscore noitalics],}#[fg=blue,bg=default,nobold,noitalics,nounderscore] "

set -g window-status-current-format "#[fg=#dddddd,bg=#1F2335]   #I #W  #{?window_last_flag,,} "
set -g window-status-format "#[fg=brightwhite,bg=#1a1b26,nobold,noitalics,nounderscore]   #I #W #F  "

set -g pane-border-style "fg=#3b4261"
set -g pane-active-border-style "fg=#7aa2f7"

set -g status-bg "#1a1b26"

set -g status-right "#[bg=default,fg=#24283B]#[fg=white,bg=#24283B] %Y-%m-%d #[]❬ %H:%M #[fg=blue,bg=#24283B,nobold,nounderscore,noitalics]#[fg=black,bg=blue,bold]󰹑 #S "
set -g window-status-separator ""
