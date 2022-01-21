source ${HOMEBREW_PREFIX}/share/chruby/chruby.sh
source ${HOMEBREW_PREFIX}/share/chruby/auto.sh

eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# autoload -Uz compinit && compinit

PROMPT='%~ %# '
