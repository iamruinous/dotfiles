function sshmux
  ssh $argv -t "tmux new-session -A -t shell"
end
