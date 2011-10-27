# aliases
alias ls="ls --color"

# configure prompt - this uses git-completion to show the branch
STARTCOLOR="\[\e[31m\]"
ENDCOLOR="\[\e[0m\]"
GITBRANCH='$(__git_ps1 "(%s)")'
export PS1="$STARTCOLOR\u@\h:\w$GITBRANCH\$ $ENDCOLOR"

# don't remember duplicates in bash history
export HISTCONTROL=ignoredups
