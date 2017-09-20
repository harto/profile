#!/usr/bin/env bash

set -ex

HERE=$(cd $(dirname $0); pwd -P)

#
# Homebrew packages
#

brew update
brew upgrade
brew tap Homebrew/bundle
cd $HERE
brew bundle

#
# Install various scripts and dotfiles
#

symlink_all() {
  source=$1
  target=$2
  find $source -type f ! -name '*~' | while read path; do
    ln -fs $path $target
  done
}

symlink_all $HERE/dotfiles ~

mkdir -p ~/bin
symlink_all $HERE/bin ~/bin
