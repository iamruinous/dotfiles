if status --is-interactive; and type -q task
  if [ "$ITERM_PROFILE" != "Hotkey Window" ]
    echo ""
    set_color blue; echo -n "Next Tasks"
    echo ""
    set_color blue; task next
    set_color normal
    echo ""
  end
end
