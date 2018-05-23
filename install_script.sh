#!/bin/bash
# use this for always having mongo running
# https://alicoding.com/how-to-start-mongodb-automatically-when-starting-your-mac-os-x/

#################### VARIABLES ########################
brew_install_with_cask() {
	list=(${@:2})
	if [[ ${#list[@]} -gt 0 ]]
	then
		echo "Will install: ${list[@]}"
		sleep 5

		for i in "${list[@]}"
		do
			if [ "$1" = true ] ; then
				brew cask install "$i"
			else
				brew install "$i"
			fi
		done
	fi
}



declare -a tools=(
	'archey'
	'dfu-util'
	'git'
	'go'
	'libusb'
	'node'
	'nvm'
	'openssl'
)
declare -a casks=(
	'1password'
	'authy'
	'docker'
	'google-chrome'
	'karabiner'
	'postman'
	'slack'
	'spectacle'
	'sublime-text'
	'virtualbox'
)

#################### EXECUTE ########################

echo "Installing xcode tools"
xcode-select --install
echo "Installing brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Saving backup of old bash_profile..." &&
cp $HOME/.bash_profile $HOME/.bash_profile_backup &&
echo "Copying dotfiles to root" &&
cp $HOME/.dotfiles/.bash_profile $HOME/ &&

echo "Installling vim settings"
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.dotfiles/.vim/bundle/vundle.vim
ln -s $HOME/.dotfiles/.vim/.vimrc $HOME/.vimrc


brew update &&
brew tap caskroom/cask &&
brew_install_with_cask false ${tools[@]} &&
brew_install_with_cask true ${casks[@]}

echo "Linking apps"
brew linkapps

echo "Changing settings..."
defaults write -g ApplePressAndHoldEnabled -bool false

