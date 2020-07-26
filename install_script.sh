#!/bin/bash
# use this for always having mongo running
# https://alicoding.com/how-to-start-mongodb-automatically-when-starting-your-mac-os-x/

#################### VARIABLES ########################
brew_install_with_cask() {
	list=(${@:2})
	if [[ ${#list[@]} -gt 0 ]]
	then
		echo "Installing... : ${list[@]}"

		for i in "${list[@]}"
		do
			if [ "$1" = true ] ; then
				if [[ ! -d /Applications/*"$1"*.app ]] ; then
					brew cask install "$i"
				fi
			else
				if ! [[ "$(command -v $i)" ]] ; then
					brew install "$i"
				fi
			fi
		done
	fi
}



declare -a tools=(
  'ack'
	'archey'
  'awscli'
	'dfu-util'
  'docker'
  'fzf'
	'git'
	'go'
	'libusb'
	'node'
	'nvm'
	'openssl'
  'ripgrep'
)
declare -a casks=(
	'1password'
	# 'authy'
	'dropbox'
	'docker'
	'google-chrome'
  'firefox'
	# 'karabiner'
	'postman'
	'signal'
	'slack'
	'spectacle'
	'sublime-text'
	'virtualbox'
)

#################### EXECUTE ########################

echo "Installing xcode tools"
xcode-select --install || softwareupdate --install xcode-select

# if ! [[ -z brew ]] ; then
if ! [[ "$(command -v brew)" ]] ; then
	echo "Installing brew"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	echo "Brew already installed"
fi

echo "Saving backup of old .zshrc..." &&
cp $HOME/.zshrc $HOME/.zshrc_backup ||
echo "No previous .zshrc"

echo "Copying dotfiles to root" &&
cp $HOME/.dotfiles/.zshrc $HOME/ &&
cp -R $HOME/.dotfiles/.zsh $HOME/

vim_path="$HOME/.dotfiles/.vim/.vimrc"
vundle_path="$HOME/.dotfiles/.vim/bundle/vundle.vim"
if [[ -a "$vim_path" ]] ; then
	echo "Installling vim settings"
	git clone "https://github.com/VundleVim/Vundle.vim.git" "$vundle_path"
	ln -s "$vim_path" "$HOME/.vimrc"
fi

tmux_path="$HOME/.dotfiles/.tmux/.tmux.conf"
tmux_plugins_path="$HOME/.dotfiles/.tmux/plugins/tpm"
if [[ -a "$tmux_path" ]] ; then
	echo "Installling tmux settings"
	git clone "https://github.com/tmux-plugins/tpm" "$tmux_plugins_path"
	ln -s "$tmux_path" "$HOME/.tmux.conf"
fi

echo "Continue with brew installs and mac settings? [y/n]"
read brew_install
if [ "$brew_install" = 'n' ]
then exit 1
fi

echo "Asking for sudo"
sudo -v

brew update &&
# brew tap caskroom/cask-cask-cask &&
brew_install_with_cask false ${tools[@]} &&
brew_install_with_cask true ${casks[@]}

#echo "Downloading non-brew apps"
if [[ ! -d /Applications/Sketch.app ]] ; then
	curl -s https://www.sketchapp.com/updates/ | grep -m 1 'a\sclass="update-download"' | grep -om 1 'http.*\.zip' | xargs curl -O && unzip sketch*.zip && mv Sketch.app/ /Applications/ && rm sketch*.zip
fi

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

echo "Finished changing settings"

