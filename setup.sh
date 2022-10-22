#!/bin/bash

# Script folder
SCRIPT_PATH=$(realpath $0)
BASEDIR=$(dirname $SCRIPT_PATH)

echo "Creating config folder..."
mkdir -p ~/.config/nvim
echo "Linking config files..."
ln -sf $BASEDIR/lua ~/.config/nvim/lua
ln -sf $BASEDIR/init.lua ~/.config/nvim/init.lua
echo "Done!"
