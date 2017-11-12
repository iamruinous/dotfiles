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
  font-firacode-nerd-font \
  font-hack \
  font-source-code-pro \
  font-fira-code

mkdir -p ~/.bin ~/go/bin ~/config/yarn/global

curl -L https://get.oh-my.fish | fish
