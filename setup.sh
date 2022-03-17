#!/bin/bash

# Script folder
SCRIPT_PATH=$(realpath $0)
BASEDIR=$(dirname $SCRIPT_PATH)

SHELL_CONFIG_FILE=$HOME/.bashrc
USER_SHELL=$(getent passwd $USER | cut -d: -f7)
# Check the default shell of user
if [ $USER_SHELL = /bin/zsh ]; then
	SHELL_CONFIG_FILE=$HOME/.zshrc
fi

TOOLS=$HOME/Tools
NEOVIM_BINARY=""
NEOVIM_VERSION="nightly"

echo "Installing neovim..."

if [ $(arch) = "x86_64" ]; then
	echo "Arch x86_64\n"

	DOWNLOAD_PATH=$TOOLS/neovim

	if [ -d $DOWNLOAD_PATH ]; then
		rm -r $DOWNLOAD_PATH
	fi

	mkdir -p $DOWNLOAD_PATH

	echo "curl -fSL https://github.com/neovim/neovim/releases/download/$NEOVIM_VERSION/nvim-linux64.tar.gz\n" 
	echo "\t -o $DOWNLOAD_PATH/nvim-linux64.tar.gz"
	curl -fSL https://github.com/neovim/neovim/releases/download/$NEOVIM_VERSION/nvim-linux64.tar.gz \
		-o $DOWNLOAD_PATH/nvim-linux64.tar.gz

	tar -xvf $DOWNLOAD_PATH/nvim-linux64.tar.gz -C $DOWNLOAD_PATH

	# check if neovim are not in PATH environment variable
	if ! [ -x "$(command -v nvim)" ]; then
		echo "Adding neovim to the PATH...\n"
		echo "export \"PATH=\$PATH:$DOWNLOAD_PATH/nvim-linux64/bin\"" >> $SHELL_CONFIG_FILE
		NEOVIM_BINARY="$DOWNLOAD_PATH/nvim-linux64/bin/nvim"
	else
		NEOVIM_BINARY="$(which nvim)"
	fi
else
	echo "Arch arm64\n"
	# check if inside a proot environment
	if [ -n "$(command -v apt-get)" ]; then
		# check if root
		if [[ $(id -u) -eq 0 ]]; then
			apt-get update
			apt-get install --no-install-recommends -y neovim
		else
			sudo apt-get update
			sudo apt-get install --no-install-recommends -y neovim
		fi
	else
		pkg update
		pkg install -y neovim
	fi

	NEOVIM_BINARY="$(which nvim)"
fi

echo "Configuring the neovim..."

echo "Creating the $HOME/.config/nvim folder..."
mkdir -p $HOME/.config/nvim/

echo "Linking the init.lua file to $HOME/.config/nvim/init.lua...\n"
ln -sf $BASEDIR/init.lua $HOME/.config/nvim/init.lua
ln -sf $BASEDIR/lua $HOME/.config/nvim/lua

echo "Installing the plugins...\n"

echo $NEOVIM_BINARY

$NEOVIM_BINARY --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

echo "Done!"
echo "Now reload or $SHELL_CONFIG_FILE with the command below:"
echo "source $SHELL_CONFIG_FILE"
