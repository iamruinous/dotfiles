if status --is-interactive; and type -q fortune
  echo -e "\e[1;30m"
  fortune
  echo -e "\e[0m"
  echo ""
end
