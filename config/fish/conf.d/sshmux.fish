function sshmux
  ssh $argv -t "tmux new-session -A -s shell"
end

function mmux
  mosh $argv -- tmux new-session -A -s shell
end
