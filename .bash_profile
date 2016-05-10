#  _              _                        __ _ _
# | |__  __ _ ___| |__    _ __  _ __ ___  / _(_) | ___
# | '_ \ / _` / __| '_ \  | '_ \| '__/ _ \| |_| | |/ _ \
# | |_) | (_| \__ \ | | | | |_) | | | (_) |  _| | |  __/
# |_.__/ \__,_|___/_| |_| | .__/|_|  \___/|_| |_|_|\___|
#                         |_|

# When Bash starts, it executes the commands in this script
# http://en.wikipedia.org/wiki/Bash_(Unix_shell)

# =====================
# Resources
# =====================

# http://cli.learncodethehardway.org/bash_cheat_sheet.pdf
# http://ss64.com/bash/syntax-prompt.html
# https://dougbarton.us/Bash/Bash-prompts.html
# http://sage.ucsc.edu/xtal/iterm_tab_customization.html

# for DOTFILE in `find $HOME/.dotfiles`
# do
# 	if [[ $DOTFILE != *".git/"* ]]; then
# 	  [ -f $DOTFILE ] && source $DOTFILE
# 	fi
# done
#source ~/.dotfiles/.alias
#source ~/.dotfiles/.bash_profile
#source ~/.dotfiles/.env
#source ~/.dotfiles/.functions
#source ~/.dotfiles/.history
#source ~/.dotfiles/.profile
#source ~/.dotfiles/.git-completion.bash
#source ~/.dotfiles/.docker-completion.bash
#source ~/.dotfiles/.bash_prompt.sh
#source ~/.dotfiles/.inputrc
# source ~/.dotfiles/.vim/.vimrc

# ====================================
# Environmental Variables and API Keys
# ====================================

# Below here is an area for other commands added by outside programs or
# commands. Attempt to reserve this area for their use!
##########################################################################
