source-file ~/.config/tmux/plugins.tmux
source-file ~/.config/tmux/common.tmux
source-file ~/.config/tmux/theme.tmux

if "test -f ~/.config/tmux/local.tmux" \
  "source-file ~/.config/tmux/local.tmux"
