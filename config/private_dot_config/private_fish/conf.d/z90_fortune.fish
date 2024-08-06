if status --is-interactive; and type -q fortune
  if [ "$ITERM_PROFILE" != "Hotkey Window" ]
    set_color brblack
    echo ""
    fortune
    set_color normal; echo ""
  end
end
