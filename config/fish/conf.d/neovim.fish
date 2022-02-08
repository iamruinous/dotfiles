if status --is-interactive; and type -q nvim
  set -Ux EDITOR nvim
  alias vim="nvim"
  alias vi="nvim"
  alias oldvim="/usr/bin/vim"
end
