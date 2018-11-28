#!/usr/local/bin/bash

sudo pkg install -y \
  cmake \
	curl \
	fish \
	direnv \
	mosh \
	git \
	tmux \
	go \
	neovim \
	rcm \
	yarn \
	wget

# Tmux TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -p \
  ~/.bin \
  ~/go/bin \
  ~/.config/yarn/global

yarn config set prefix ~/.config/yarn/global

yarn global add \
  eslint \
  hs \
  javascript-language-server \
  prettier \
  wscat

# Python stuff
sudo pip install neovim yamllint python-language-server

# omf
curl -L https://get.oh-my.fish | fish

# utils
go get -u github.com/golang/lint/golint
go get -u github.com/alecthomas/gometalinter
go get -u github.com/sourcegraph/go-langserver

# rust
curl https://sh.rustup.rs -sSf | sh
rustup component add rls-preview rust-analysis rust-src rustfmt-preview
cargo install exa
