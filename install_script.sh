#!/bin/bash
# use this for always having mongo running
# https://alicoding.com/how-to-start-mongodb-automatically-when-starting-your-mac-os-x/

#################### VARIABLES ########################

declare -a tools=(
  # 'ack'
  # 'archey'
  # 'awscli'
  'dfu-util'
  'docker'
  'fzf'
  'git'
  # 'go'
  'libusb'
  'nvm'
  'neovim'
  'openssl'
  'ripgrep'
)

declare -a casks=(
  '1password'
  # 'authy'
  # 'dropbox'
  # 'docker'
  # 'google-chrome'
  'firefox'
  # 'karabiner'
  'postman'
  'rectangle'
  'signal'
  # 'slack'
  # 'sublime-text'
  # 'virtualbox'
)

function ask_yes_no {
    echo ""
    local prompt="$1"
    while true; do
        read -rp "$prompt (y/n): " response
        case "$response" in
            [Yy]* ) return 0 ;; # User answered yes
            [Nn]* ) return 1 ;; # User answered no
            * ) echo "Invalid input. Please answer y or n." ;;
        esac
    done
}

brew_install_with_cask() {
	list=(${@:2})
	if [[ ${#list[@]} -gt 0 ]]
	then
		echo "Installing... : ${list[@]}"

		for i in "${list[@]}"
		do
			if [ "$1" = true ] ; then
				if [[ ! -d /Applications/*"$1"*.app ]] ; then
					brew install --cask "$i"
				fi
			else
				if ! [[ "$(command -v $i)" ]] ; then
					brew install "$i"
				fi
			fi
		done
	fi
}

#################### EXECUTE ########################
dotfiles_path="$HOME/.dotfiles"

if ask_yes_no "Install bash_profile?"; then
  echo "Saving backup of old bash_profile..." &&
  cp $HOME/.bash_profile $HOME/.bash_profile_backup ||
  echo "No previous bash_profile"

  echo "Copying dotfiles to root" &&
  cp $HOME/.dotfiles/.bash_profile $HOME/
fi

if ask_yes_no "Install zshrc?"; then
  echo "Saving backup of old zshrc..." &&
  cp $HOME/.zshrc $HOME/.zshrc_backup ||
  echo "No previous zshrc"

  echo "Linking zshrc to root" &&
  ln -s "$dotfiles_path/.zshrc" "$HOME/.zshrc.personal"
fi

vim_path="$HOME/.dotfiles/.vim/.vimrc"
vundle_path="$HOME/.dotfiles/.vim/bundle/vundle.vim"
if [ -e "$vim_path" ] ; then
	if ask_yes_no "Install custom vim settings and vundle?"; then
		echo "Installling vim settings"
		git clone "https://github.com/VundleVim/Vundle.vim.git" "$vundle_path"
		ln -s "$vim_path" "$HOME/.vimrc"

		if [ ! -f $HOME/.config/nvim/init.vim ] ; then
      echo "No .config/nvim/init.vim"
      initvim=$HOME/.config/nvim/init.vim
      mkdir -p $HOME/.config/nvim
      touch "$initvim"
      echo "set runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after" >> "$initvim"
      echo "let &packpath=&runtimepath" >> "$initvim"
      echo "source $HOME/.vimrc" >> "$initvim"
		fi

    pip3 install pynvim
	fi
fi

tmux_path="$HOME/.dotfiles/.tmux/.tmux.conf"
tmux_plugins_path="$HOME/.dotfiles/.tmux/plugins/tpm"
if [ -e "$tmux_path" ] ; then
	if ask_yes_no "Install custom tmux settings?"; then
		echo "Installling tmux settings"
		git clone "https://github.com/tmux-plugins/tpm" "$tmux_plugins_path"
		ln -s "$tmux_path" "$HOME/.tmux.conf"
	fi
fi

# Check OS
if [[ "$(uname -s)" == "Darwin" ]]; then
  # Install brew + common casks
  echo "This is macOS."

  if ask_yes_no "Instal xcode tools?"; then
    xcode-select --install || softwareupdate --install xcode-select
  fi

  if ask_yes_no "Install brew?"; then
    echo "Asking for sudo"
    sudo -v
    if ! [[ "$(command -v brew)" ]] ; then
      echo "Installing brew"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
      echo "Brew already installed"
    fi

    brew update

    if ask_yes_no "Install the following tools? $(echo ${tools[@]})"; then
      brew_install_with_cask false ${tools[@]}
    fi
    if ask_yes_no "Install the following casks? $(echo ${casks[@]})"; then
      brew_install_with_cask true ${casks[@]}
    fi
  fi

  if ask_yes_no "Change Mac settings to preferred settings?"; then
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
  fi
fi

if ask_yes_no "Install oh-my-zsh?"; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&
  echo "source $HOME/.zshrc.personal" >> .zshrc
fi
