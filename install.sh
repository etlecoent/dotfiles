#!/bin/bash

set -e

DOTFILES_REPO="git@github.com:etlecoent/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

echo "==> Dotfiles Installation Script"
echo ""

# Check if dotfiles directory already exists
if [ -d "$DOTFILES_DIR" ]; then
    echo "Dotfiles directory already exists at $DOTFILES_DIR"
    echo "Pulling latest changes..."
    cd "$DOTFILES_DIR"
    git pull
else
    echo "Cloning dotfiles repository..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    cd "$DOTFILES_DIR"
fi

echo ""
echo "==> Running setup script..."
bash setup.sh

echo ""
echo "==> Installation complete!"
