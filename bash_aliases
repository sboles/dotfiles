# Adds an alias to the current shell and to this file.
# Borrowed from Mislav (http://github.com/mislav/dotfiles/tree/master/bash_aliases)
add-alias ()
{
   local name=$1 value=$2
   echo "alias $name='$value'" >> ~/.bash_aliases
   eval "alias $name='$value'"
   alias $name
}

############################################################
## List
############################################################

if [[ `uname` == 'Darwin' ]]; then
  alias ls="ls -G"
  # good for dark backgrounds
  export LSCOLORS=gxfxcxdxbxegedabagacad
else
  alias ls="ls --color=auto"
  # good for dark backgrounds
  export LS_COLORS='no=00:fi=00:di=00;36:ln=00;35:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;31:'
  # For LS_COLORS template: $ dircolors /etc/DIR_COLORS
fi

alias l="ls"
alias ll="ls -l"
alias la="ls -a"
alias lal="ls -al"

############################################################
## Git
############################################################

alias g="git"
alias gb="git branch -a -v"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gd="git diff"
alias gl="git pull"
alias glr="git pull --rebase"
alias gp="git push"
alias gs="git status"
alias gg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias ggs="gg --stat"
alias gh="github"
alias gsl="git shortlog -sn"
alias gw="git whatchanged"
alias gsr="git svn rebase"
alias gsp="git svn dcommit"

# Useful report of what has been committed locally but not yet pushed to another
# branch.  Defaults to the remote origin/master.  The u is supposed to stand for
# undone, unpushed, or something.
function gu {
  local branch=$1
  if [ -z "$1" ]; then
    branch=master
  fi
  if [[ ! "$branch" =~ "/" ]]; then
    branch=origin/$branch
  fi
  local cmd="git cherry -v $branch"
  echo $cmd
  $cmd
}

function gco {
  if [ -z "$1" ]; then
    git checkout master
  else
    git checkout $*
  fi
}

function st {
  if [ -d ".svn" ]; then
    svn status
  else
    git status
  fi
}

############################################################
## Subversion
############################################################

# Remove all .svn folders from directory recursively
alias svn-clean='find . -name .svn -print0 | xargs -0 rm -rf'

############################################################
## OS X
############################################################

# Get rid of those pesky .DS_Store files recursively
alias dstore-clean='find . -type f -name .DS_Store -print0 | xargs -0 rm'

# Track who is listening to your iTunes music
alias whotunes='lsof -r 2 -n -P -F n -c iTunes -a -i TCP@`hostname`:3689'

############################################################
## Bundler
############################################################

alias b="bundle"
alias bu="b update"
alias be="b exec"
alias bi="b install --path vendor"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

############################################################
## Ruby
############################################################

alias r="rake"
alias a="rake db:test:clone && autotest -q"
alias smp="staticmatic preview ."

export GEMS=`gem env gemdir`/gems
function gemfind {
  echo `ls $GEMS | grep -i $1 | sort | tail -1`
}

# Use: gemcd <name>, cd's into your gems directory
# that best matches the name provided.
function gemcd {
  cd $GEMS/`gemfind $1`
}

# Use: gemdoc <gem name>, opens the rdoc of the gem
# that best matches the name provided.
function gemdoc {
  open $GEMS/../doc/`gemfind $1`/rdoc/index.html
}

############################################################
## Rails
############################################################

alias ss="script/server"
alias sg="script/generate"
alias sc="script/console"
alias tl='tail -f log/development.log'

############################################################
## Miscellaneous
############################################################

if [ -f /Applications/Emacs.app/Contents/MacOS/Emacs ]; then
  alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
  alias emacsclient='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
fi

alias serve='python -m SimpleHTTPServer'
alias grep='GREP_COLOR="1;37;41" grep --color=auto'
alias wgeto="wget -q -O -"
alias sha1="openssl dgst -sha1"
alias sha2="openssl dgst -sha256"
alias b64="openssl enc -base64"

alias flushdns='dscacheutil -flushcache'

############################################################
