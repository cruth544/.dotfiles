#  _               _                        __ _ _
# | |__   __ _ ___| |__    _ __  _ __ ___  / _(_) | ___
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

for DOTFILE in `find $HOME/.dotfiles/.zsh_files`
do
	 [[ -f $DOTFILE ]] && source $DOTFILE
done
zstyle ':completion:*:*:git:*' script ~/.dotfiles/.bash_files/.git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

# Enables fzf
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# source ~/.dotfiles/.docker-completion.bash # If you have docker installed
# source ~/.dotfiles/.vim/.vimrc # Follow README.md under .vim folder

# ====================================
# Environmental Variables and API Keys
# ====================================
export EDITOR=vim
set -o emacs

# Below here is an area for other commands added by outside programs or
# commands. Attempt to reserve this area for their use!
##########################################################################
