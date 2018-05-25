#!/bin/bash
# use this for always having mongo running
# https://alicoding.com/how-to-start-mongodb-automatically-when-starting-your-mac-os-x/

#################### VARIABLES ########################
brew_install_with_cask() {
	list=(${@:2})
	if [[ ${#list[@]} -gt 0 ]]
	then
		echo "Installing... : ${list[@]}"
		sleep 5

		for i in "${list[@]}"
		do
			if [[ -z "$1" ]] ; then
				if [ "$1" = true ] ; then
					brew cask install "$i"
				else
					brew install "$i"
				fi
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
	'dropbox'
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
xcode-select --install || softwareupdate --install xcode-select

if [[ -z brew ]] ; then
	echo "Installing brew"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Saving backup of old bash_profile..." &&
cp $HOME/.bash_profile $HOME/.bash_profile_backup ||
echo "No previous bash_profile"

echo "Copying dotfiles to root" &&
cp $HOME/.dotfiles/.bash_profile $HOME/

vim_path="$HOME/.dotfiles/.vim/.vimrc"
vundle_path="$HOME/.dotfiles/.vim/bundle/vundle.vim"
if [[ -L "$vim_path" ]] ; then
	echo "Installling vim settings"
	git clone "https://github.com/VundleVim/Vundle.vim.git" "$vundle_path"
	ln -s "$vim_path" "$HOME/.vimrc"
fi

echo "Asking for sudo"
sudo -v

brew update &&
brew tap caskroom/cask &&
brew_install_with_cask false ${tools[@]} &&
brew_install_with_cask true ${casks[@]}

#echo "Downloading non-brew apps"
#curl -s https://www.sketchapp.com/updates/ | grep -m 1 'a\sclass="update-download"' | grep -om 1 'http.*\.zip' | xargs curl -O

echo "Changing Mac settings..."
# Kill System Preferences to prevent override
osascript -e 'tell application "System Preferences" to quit'

# Enable key repeat instead of accents
defaults write -g ApplePressAndHoldEnabled -bool false

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -arr

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Set key repeat to fast
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 20

# Set scrool direction to normal
defaults write -g com.apple.swipescrolldirection -bool false

# Set new Finder window default location
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
#defaults write -currentHost NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`, `Nlsv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Show battery percent at top
defaults write com.apple.menuextra.battery ShowPercent YES &&
killall SystemUIServer

echo "Finished changing settigns"

