if status --is-interactive; and type -q task
  echo ""
  set_color blue; echo -n "Next Tasks"
  echo ""
  set_color blue; task next
  set_color normal
  echo ""
end
