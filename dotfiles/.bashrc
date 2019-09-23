# Shell configuration


### Deferred initializers

# Some initialization code noticeably slows down opening a new terminal tab.
# We can momentarily defer these slow initializers to give the impression of
# faster load time.

__deferred_initializers=()

add_deferred_initializer() {
  __deferred_initializers+=("$1")
}

__run_deferred_initializers() {
  for initializer in ${__deferred_initializers[*]}; do
    $initializer
  done
}


### Prompt

PS1="\n\w › "

__configure_git_prompt() {
  if [[ $(type -t __git_ps1) == "function" ]]; then
    export GIT_PS1_DESCRIBE_STYLE=branch
    export GIT_PS1_SHOWCOLORHINTS=1
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    PROMPT_COMMAND='__git_ps1 "\n\w" " › "'
  else
    PS1="\n\w › "
  fi
}

__configure_bash_completion() {
  if [[ -f /usr/local/etc/bash_completion ]]; then
    # if the output of `set` contains non-ASCII chars we get a `sed` error from
    # git-completion.bash. Therefore we temporarily remove any fancy prompt
    # characters while that file is sourced.
    PS1=
    source /usr/local/etc/bash_completion
    # Can't set git prompt until bash completion is loaded.
    __configure_git_prompt

    __git_complete gb _git_branch
    __git_complete gco _git_checkout
    __git_complete gci _git_commit
    __git_complete gd _git_diff
    __git_complete gp _git_pull
    __git_complete gpull _git_pull
    __git_complete gst _git_status
  fi
}

# Loading bash completion on OSX is quite slow (~200ms), so defer it until
# after the prompt is shown.
add_deferred_initializer __configure_bash_completion


### History

# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=10000
HISTFILESIZE=$HISTSIZE


### Miscellany

# Don't clear screen after quitting `man'
export MANPAGER="less -X"

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Colourised `ls`, etc.
export CLICOLOR=1


### Private/local settings

if [[ -r ~/.profile ]]; then
  source ~/.profile
fi


### Aliases

alias be="bundle exec"
alias e.='$EDITOR .'
alias e='$EDITOR'
alias g=git
alias gb="g b"
alias gco="g co"
alias gci="g ci"
alias gd="g d"
alias gdiff="gd"
alias gp="g p"
alias gpull="gp"
alias gst="g st"
alias less="less -X"

### Run deferred initialization

# If we're using bash to run some command in a fully-initialized environment
# (e.g. "bash -lc ruby prog.rb") we need to run all initializers immediately.
# Otherwise, let the prompt show before running them in the background.

# TODO: figure out if this is a good way of distinguishing between these use
# cases
if [[ $0 == '-bash' ]]; then
  trap '__run_deferred_initializers; trap USR1' USR1
  { sleep 0.01; builtin kill -USR1 $$; } & disown
else
  __run_deferred_initializers
fi
