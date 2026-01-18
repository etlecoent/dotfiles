#!/bin/bash

set -e

echo "==> Installing Starship prompt..."
if command -v starship &> /dev/null; then
    echo "Starship already installed"
else
    curl -sS https://starship.rs/install.sh | sh
fi

echo ""
echo "==> Installing Keychain (requires sudo)..."
if command -v keychain &> /dev/null; then
    echo "Keychain already installed"
else
    sudo apt install -y keychain
fi

echo ""
echo "==> Installing Claude Code..."
if command -v claude &> /dev/null; then
    echo "Claude Code already installed"
else
    curl -fsSL https://claude.ai/install.sh | bash
fi

echo ""
echo "==> Setting up dotfiles..."

# Create .zshenv to source zsh configuration
cat > ~/.zshenv << 'EOF'
# Source zsh configuration from dotfiles
source "$HOME/dotfiles/zsh/zshrc"
EOF

# SSH configuration
ln -sf ~/dotfiles/ssh/config ~/.ssh/config

# Git configuration
ln -sf ~/dotfiles/gitconfig ~/.gitconfig

# Claude configuration
mkdir -p ~/.claude
ln -sf ~/dotfiles/claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/claude/statusline.sh ~/.claude/statusline.sh
ln -sf ~/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md

echo ""
echo "==> Dotfiles setup complete!"
echo "Restart your shell or run: source ~/.zshenv"