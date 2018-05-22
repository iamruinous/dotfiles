#!/bin/bash

brew tap \
  heroku/brew \
  osx-cross/avr \
  PX4/homebrew-px4 \

# golang
brew install \
  dep \
  ipfs \
  go \
  gx \
  gx-go

# elixir
brew install \
  elixir

# rust
brew install \
  rust

# python
brew install \
  python \
  python\@2

# vim
brew install \
  ctags \
  neovim \
  ripgrep \
  the_silver_searcher \

# utils
brew install \
  awscli \
  curl \
  doctl \
  git \
  gnupg \
  gpg-agent \
  gron \
  heroku \
  htop \
  jsonlint \
  jq \
  pinentry-mac \
  p7zip \
  ssh-copy-id \
  sqlite \
  tmux \
  watch \
  webp \
  wget \
  xz

go get -u github.com/golang/lint/golint
go get -u github.com/alecthomas/gometalinter

pip3 install neovim yamllint
