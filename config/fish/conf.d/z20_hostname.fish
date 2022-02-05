if status --is-interactive; and type -q toilet; and type -q lolcat
  if test -z "$TOILETNAME"
    set TOILETNAME (hostname -s)
  end
  if test -z "$TOILETFONT"
    if test (string length "$TOILETNAME") -gt 15
      set TOILETFONT "future"
    else
      set TOILETFONT "smblock"
    end
  end
  echo "$TOILETNAME" | toilet -f "$TOILETFONT" | lolcat
end
