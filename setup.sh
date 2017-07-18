#!/usr/bin/env bash

set -ex

#
# Homebrew packages
#

brew update

FORMULAE="
aws-keychain
bash
bash-completion
chruby
git
hub
ruby-install
tmux
"

for f in $FORMULAE; do
  brew install $f
done

CASK_FORMULAE="
emacs
"

for cf in $CASK_FORMULAE; do
  brew cask install $cf
done

#
# Install configs
#

DOTFILES_DIR="$(cd $(dirname $0); pwd -P)/dotfiles"
cd ~
find $DOTFILES_DIR -type f | while read path; do
  ln -fs $path
done
