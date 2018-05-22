#!/bin/bash

brew tap thoughtbot/formulae
brew install rcm

brew tap \
  caskroom/fonts \
  heroku/brew \
  homebrew/core \
  osx-cross/avr \
  px4/px4 \

brew install \
  ripgrep \
  awscli \
  direnv \
  rbenv \
  mongodb \
  tmux \
  watch \
  xz \
  jq \
  ipfs \
  mosh \
  ctags \
  curl \
  dep \
  elixir \
  fish \
  hub \
  p7zip \
  webp \
  ssh-copy-id \
  wget \
  redis \
  the_silver_searcher \
  node \
  yarn \
  go \
  gx \
  gx-go \
  git \
  gnupg \
  gpg-agent \
  htop \
  jsonlint \
  rust \
  sqlite \
  python \
  python\@2 \
  neovim \
  heroku \
  shpotify \
  gron \
  doctl \
  pinentry-mac

# casks
brew cask install \
  1password \
  alfred \
  calibre \
  cleanmymac \
  docker \
  dropbox \
  firefox \
  fission \
  flycut \
  font-fira-code \
  font-firacode-nerd-font \
  font-hack \
  font-source-code-pro \
  gitify \
  google-chrome \
  iterm2 \
  java \
  kaleidoscope \
  keybase \
  little-snitch \
  mactex \
  multipatch \
  obs \
  omnigraffle \
  private-internet-access \
  qmk-toolbox \
  sketch \
  slack \
  spotify \
  steam \
  taskwarrior-pomodoro \
  teamviewer \
  the-unarchiver \
  transmission \
  transmit \
  virtualbox \
  virtualbox-extension-pack \
  vlc \
  wavebox

# after java
brew install \
  bfg \
  task \
  tasksh \
  timewarrior

mkdir -p ~/.bin ~/go/bin ~/config/yarn/global

curl -L https://get.oh-my.fish | fish
yarn config set prefix ~/.config/yarn/global

yarn global add \
  eslint \
  hs \
  wscat \
  prettier

go get -u github.com/golang/lint/golint
go get -u github.com/alecthomas/gometalinter

pip3 install neovim yamllint
