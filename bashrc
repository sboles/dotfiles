## This file is sourced by all *interactive* bash shells on startup.  This
## file *should generate no output* or it will break the scp and rcp commands.
############################################################

if [ -e /etc/bashrc ] ; then
  . /etc/bashrc
fi

############################################################
## PATH
############################################################

if [ -d /usr/local/bin ] ; then
  PATH="/usr/local/bin:${PATH}"
fi

if [ -d /usr/local/sbin ] ; then
  PATH="${PATH}:/usr/local/sbin"
fi

PATH=.:${PATH}

############################################################
## MANPATH
############################################################

if [ -d /usr/local/man ] ; then
  MANPATH="/usr/local/man:${MANPATH}"
fi

############################################################
## Other paths
############################################################

############################################################
## RVM
############################################################

if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

############################################################
## Terminal behavior
############################################################

# Change the window title of X terminals
case $TERM in
  xterm*|rxvt|Eterm|eterm)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
    ;;
  screen)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
    ;;
esac

# Show the git branch and dirty state in the prompt.
# Borrowed from: http://henrik.nyh.se/2008/12/git-dirty-prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\(\1$(parse_git_dirty)\)/"
}

if [ `which git` ]; then
  function git_prompt {
    parse_git_branch
  }
else
  function git_prompt {
    echo ""
  }
fi

if [ `which rvm-prompt` ]; then
  function rvm_prompt {
    echo "($(rvm-prompt v g))"
  }
else
  function rvm_prompt {
    echo ""
  }
fi

# Do not set PS1 for dumb terminals
if [ "$TERM" != 'dumb' ] && [ -n "$BASH" ]; then
  export PS1='\[\033[32m\]\n[\s: \w] $(rvm_prompt) $(git_prompt)\n\[\033[31m\][\u@\h]\$ \[\033[00m\]'
fi

############################################################
## Optional shell behavior
############################################################

shopt -s cdspell
shopt -s extglob
shopt -s checkwinsize

export PAGER="less"
export EDITOR="vi"

############################################################
## History
############################################################

export HISTSIZE=100000                   # big big history
# When you exit a shell, the history from that session is appended to
# ~/.bash_history.  Without this, you might very well lose the history of entire
# sessions (weird that this is not enabled by default).
shopt -s histappend                      # append to history, don't overwrite it

export HISTIGNORE="&:pwd:ls:ll:lal:[bf]g:exit:rm*:sudo rm*"
# remove duplicates from the history (when a new item is added)
export HISTCONTROL=ignoredups            # ignore duplicate entries

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

############################################################
## Aliases
############################################################

if [ -e ~/.bash_aliases ] ; then
  . ~/.bash_aliases
fi

############################################################
## Bash Completion, if available
############################################################

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

############################################################
## Other
############################################################

if [ -f /usr/local/etc/bash_completion.d/cdargs-bash.sh ]; then
  source /usr/local/etc/bash_completion.d/cdargs-bash.sh
fi

if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
  source /usr/local/etc/bash_completion.d/git-completion.bash
fi

if [[ "$USER" == '' ]]; then
  # mainly for cygwin terminals. set USER env var if not already set
  USER=$USERNAME
fi

############################################################

# VI Mode

set -o vi
