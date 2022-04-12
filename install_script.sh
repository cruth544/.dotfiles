#!/bin/bash
# use this for always having mongo running
# https://alicoding.com/how-to-start-mongodb-automatically-when-starting-your-mac-os-x/

#################### VARIABLES ########################
#################### EXECUTE ########################

echo "Saving backup of old bash_profile..." &&
cp $HOME/.bash_profile $HOME/.bash_profile_backup ||
echo "No previous bash_profile"

echo "Copying dotfiles to root" &&
cp $HOME/.dotfiles/.bash_profile $HOME/

vim_path="$HOME/.dotfiles/.vim/.vimrc"
vundle_path="$HOME/.dotfiles/.vim/bundle/vundle.vim"
if [ -L "$vim_path" ] ; then
	echo "Installling vim settings"
	git clone "https://github.com/VundleVim/Vundle.vim.git" "$vundle_path"
	ln -s "$vim_path" "$HOME/.vimrc"
fi

tmux_path="$HOME/.dotfiles/.tmux/.tmux.conf"
tmux_plugins_path="$HOME/.dotfiles/.tmux/plugins/tpm"
if [ -L "$tmux_path" ] ; then
	echo "Installling tmux settings"
	git clone "https://github.com/tmux-plugins/tpm" "$tmux_plugins_path"
	ln -s "$tmux_path" "$HOME/.tmux.conf"
fi

