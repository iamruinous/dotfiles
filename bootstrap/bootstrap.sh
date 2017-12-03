#!/bin/bash

brew tap thoughtbot/formulae
brew tap caskroom/fonts

brew install \
  direnv \
  rbenv \
  rcm \
  mongodb \
  tmux \
  watch \
  xz \
  jq \
  ipfs \
  ctags \
  curl \
  dep \
  elixir \
  fish \
  hub \
  ssh-copy-id \
  wget \
  redis \
  the_silver_searcher \
  node \
  yarn \
  go \
  git \
  gnupg \
  gpg-agent \
  htop \
  jsonlint \
  rust \
  sqlite \
  python3 \
  neovim \
  heroku \
  gpg-agent \
  pinentry-mac

brew cask install \
  gitify \
  font-firacode-nerd-font \
  font-hack \
  font-source-code-pro \
  font-fira-code \
  omnigraffle \
  firefox \
  the-unarchiver \
  wavebox \
  steam \
  transmission \
  keybase \
  kaleidoscope \
  google-chrome \
  dropbox \
  docker \
  iterm2 \
  cleanmymac \
  sketch \
  slack \
  spotify \
  1password \
  transmit \
  private-internet-access \
  virtualbox \
  virtualbox-extension-pack

mkdir -p ~/.bin ~/go/bin ~/config/yarn/global

curl -L https://get.oh-my.fish | fish
yarn config set prefix ~/.config/yarn/global

yarn global add \
  eslint \
  prettier

go get -u github.com/golang/lint/golint
go get -u github.com/alecthomas/gometalinter

pip3 install neovim
