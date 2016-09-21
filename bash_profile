for file in ~/.env.d/**; do
  source $file
done

export NVM_DIR="/Users/jmeskill/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
