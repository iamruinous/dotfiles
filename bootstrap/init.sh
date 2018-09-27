#!/bin/bash

brew tap thoughtbot/formulae
brew install rcm
brew install \
  direnv \
  fish \
  hub \
  rbenv \
  yarn 

rcup -v

mkdir -p \
  ~/.bin \
  ~/go/bin \
  ~/.config/yarn/global

yarn config set prefix ~/.config/yarn/global

yarn global add \
  eslint \
  hs \
  wscat \
  prettier


curl -L https://get.oh-my.fish | fish
