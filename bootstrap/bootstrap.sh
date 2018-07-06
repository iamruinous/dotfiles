#!/bin/bash

brew tap \
  heroku/brew

brew tap
  osx-cross/avr \
  px4/px4 \

# java
brew cask install \
  java

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
  gitify \
  google-chrome \
  iterm2 \
  kaleidoscope \
  keybase \
  little-snitch \
  mactex \
  multipatch \
  obs \
  omnigraffle \
  private-internet-access \
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

brew install qmk-toolbox
