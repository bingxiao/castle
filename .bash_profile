# Only bashisms go in this file
# We use ~/.bash_profile instead of ~/.bashrc, which isn't always loaded
source ~/.profile

# Setup completion
source ~/bin/git-completion.bash

# Avoid succesive duplicates in history
export HISTCONTROL=ignoredups

# Append commands to the bash command history file (~/.bash_history)
# instead of overwriting it.
shopt -s histappend

# Append commands to the history every time a prompt is shown,
# instead of after closing the session.
PROMPT_COMMAND='history -a'

