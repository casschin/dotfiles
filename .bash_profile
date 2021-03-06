# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Using this, consecutive duplicate commands, invocations
# of ls, plus calls to the bg, fg and exit
# built-ins will not be appended to the history list.
HISTIGNORE="&:ls:ls *:[bf]g:exit:vi"
export HISTIGNORE

##############################################################################
# git
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ [\1$(parse_git_dirty)]/"
}

if [ -f ~/.config/.git-completion.bash ]; then
		. ~/.config/.git-completion.bash
fi

##############################################################################
# two-line ps1
# $
PS1='\[\033[01;37m\]\w$(parse_git_branch)\n$ \[\033[00m\]'

##############################################################################
# aliases
alias ls='ls -FG'
alias l='ls -aFG'
alias ll='ls -alFG'

alias rm='rm -i'
alias .='pwd'
alias ..='cd ..'
alias simulator='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'

alias weather='curl -4 http://wttr.in/nyc'
alias ebash='vim ~/.bash_profile'
alias rbash='source ~/.bash_profile'

##############################################################################
# defaults
EDITOR=vi;   	export EDITOR
PAGER=less;  	export PAGER # git diff expects 'less' for best output
PATH=$PATH:$HOME/bin:/usr/local/sbin

##############################################################################
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source $NVM_DIR/nvm.sh

export PATH="$HOME/.yarn/bin:$PATH"

ssh-add
