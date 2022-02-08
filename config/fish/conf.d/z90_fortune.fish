if status --is-interactive; and type -q fortune
  set_color brblack
  echo ""
  fortune
  set_color normal; echo ""
end
