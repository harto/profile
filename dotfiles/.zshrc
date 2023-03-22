source ${HOMEBREW_PREFIX}/share/chruby/chruby.sh
source ${HOMEBREW_PREFIX}/share/chruby/auto.sh

eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# TODO: I think this belongs in .zshenv so that it works with non-login(?) /
# non-interactive(?) shells. But if I put it in .zshenv, something ends up
# putting /usr/bin near the start of the list, which means the stub java command
# gets run before the Homebrew-installed (openjdk) one.
path=(
  $HOME/bin
  $HOME/remix/bin
  $REMIX_HOME/bin
  ${HOMEBREW_PREFIX}/opt/openjdk/bin
  ${HOMEBREW_PREFIX}/bin
  $path
)
export PATH

# autoload -Uz compinit && compinit

PROMPT='%~ %# '

if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
  source ~/.emacs.d/etc/vterm.zsh
fi
