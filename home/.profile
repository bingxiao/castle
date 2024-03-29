# General shell configuration for zsh and bash
# See also:
#   .bash_profile
#   .zshrc

# Setup PATH
# TODO: Avoid duplicating paths whenever ~/.profile is sourced
# TODO: Update to Python 2.7.2
export PATH="/usr/texbin:${PATH}"           	               # texlive
export PATH="/usr/local/bin:/usr/local/sbin:${PATH}"           # brew path
export PATH="/usr/local/Cellar/ruby/1.9.2-p290/bin:${PATH}"    # Ruby 1.9 (brew version)
export PATH="/usr/local/share/python:${PATH}"                  # Python 2.7 binaries (see brew info python)

# Setup other environment variables
export EDITOR=vim                       # just kidding! I run cocoa emacs
export CLICOLOR=1                       # enable colors for ls
export LSCOLORS=ExFxCxDxBxegedabagacad  # readable colors for ls

# Aliases
# TODO: Move to ~/.aliases
alias pg="ping google.com" # connection test
alias ls="ls --color"
alias htop="sudo htop"  # htop needs to run as root on OS X
alias emacs="emacs -nw"
alias macemacs=/usr/local/Cellar/emacs/HEAD/Emacs.app/Contents/MacOS/Emacs
#alias grep='grep --color=auto --exclude-dir=\.svn' # hightlight matches & exclude .svn 

# Setup Python virtualenvs
export WORKON_HOME=$HOME/virtualenvs
export VIRTUALENVWRAPPER_PYTHON=python2.7
VIRTUALENWRAPPER_SCRIPT="/usr/local/share/python/virtualenvwrapper.sh"
[[ -s $VIRTUALENWRAPPER_SCRIPT ]] && . $VIRTUALENWRAPPER_SCRIPT

# Setup RVM
[[ -s "/Users/natan/.rvm/scripts/rvm" ]] && . "/Users/natan/.rvm/scripts/rvm"  
