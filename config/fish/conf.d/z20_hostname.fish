if status --is-interactive; and type -q toilet; and type -q lolcat
  if test -z "$TOILETNAME"
    set TOILETNAME (hostname -s)
  end
  if test -z "$TOILETFONT"
    if test (string length "$TOILETNAME") -gt 10
      set TOILETFONT "smblock"
    else
      set TOILETFONT "smmono12"
    end
  end
  echo "$TOILETNAME" | toilet -f "$TOILETFONT" | lolcat
end
