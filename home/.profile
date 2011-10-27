# General shell configuration for zsh and bash
# See also:
#   .bash_profile
#   .zshrc

# Setup PATH
# TODO: Avoid duplicating paths whenever ~/.profile is sourced
export PATH="/usr/local/bin:/usr/local/sbin:${PATH}"            # brew path
export PATH="/usr/local/Cellar/ruby/1.9.2-p136/bin/:${PATH}"    # Ruby 1.9 (brew version)
export PATH="/usr/local/Cellar/python/2.7.1/bin/:${PATH}"       # Python 2.7 binaries (e.g. from pip)

# Setup other environment variables
export EDITOR=vim                       # one day this will be emacs
export CLICOLOR=1                       # enable colors for ls
export LSCOLORS=ExFxCxDxBxegedabagacad  # readable colors for ls

# Setup Python virtualenvs
export WORKON_HOME=$HOME/virtualenvs
export VIRTUALENVWRAPPER_PYTHON=python2.7
source /usr/local/Cellar/python/2.7.1/bin/virtualenvwrapper.sh

# Aliases
# TODO: Move to ~/.aliases
alias emacs="emacs -nw"
alias macemacs=/usr/local/Cellar/emacs/HEAD/Emacs.app/Contents/MacOS/Emacs
#alias grep='grep --color=auto --exclude-dir=\.svn' # hightlight matches & exclude .svn 

