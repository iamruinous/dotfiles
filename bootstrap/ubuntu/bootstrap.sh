#!/bin/bash

# essentials
sudo apt-get install --yes \
	build-essential \
  cmake \
  curl \
  direnv \
  fish \
  golang \
  htop \
  hub \
  jq \
	mosh \
	neofetch \
  neovim \
  nodejs \
  python-dev \
  python-pip \
  python3-dev \
  python3-pip \
 	tmux \
  wget \
  xz-utils

# neovim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install --yes yarn

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

# omf
curl -L https://get.oh-my.fish | fish

# utils
go get -u github.com/golang/lint/golint
go get -u github.com/alecthomas/gometalinter
go get -u github.com/sourcegraph/go-langserver

pip3 install neovim yamllint python-language-server
pip install neovim yamllint python-language-server

curl https://sh.rustup.rs -sSf | sh
rustup component add rls-preview rust-analysis rust-src rustfmt-preview
cargo install exa
