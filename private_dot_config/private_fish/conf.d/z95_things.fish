if status --is-interactive; and type -q things-cli
  if [ $ITERM_PROFILE != "Hotkey Window" ]
    set -l things_today (things-cli today)
    set -l things_count (count $things_today)
    echo ""
    set_color green; echo -n "Today's Top Things [$things_count]"
    set -l inbox_count (things-cli inbox | wc -l | string trim)
    if test $inbox_count -gt 0
      set_color grey; echo -n " | "
      set_color yellow; echo "Inbox [$inbox_count]"
      set_color normal
    end
    echo ""
    set_color green; printf "%s\n" $things_today[1..5]
    set_color normal
    echo ""
  end
end
