#!/usr/bin/env bash

set -ex

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

for f in $CASK_FORMULAE; do
  brew cask install $f
done
