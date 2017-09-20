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
# Install configs
#

DOTFILES_DIR="$(cd $(dirname $0); pwd -P)/dotfiles"
cd ~
find $DOTFILES_DIR -type f | while read path; do
  ln -fs $path
done
