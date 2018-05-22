#!/bin/bash

brew tap thoughtbot/formulae
brew install rcm
brew install \
  fish \
  direnv

rcup -v

mkdir -p ~/.bin ~/go/bin ~/config/yarn/global

curl -L https://get.oh-my.fish | fish
