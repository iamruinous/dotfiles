if status --is-interactive; and type -q dfrs
  if [ "$ITERM_PROFILE" != "Hotkey Window" ]
    dfrs
    echo ""
  end
end
