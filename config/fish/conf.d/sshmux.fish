function sshmux
  ssh $argv -t "tmux new-session -A -s shell"
end
