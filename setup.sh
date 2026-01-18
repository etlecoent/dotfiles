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
echo "==> Setting up SSH key for GitHub..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh

if [ -f ~/.ssh/id_github ]; then
    echo "SSH key already exists at ~/.ssh/id_github"
else
    echo "Generating new SSH key..."
    ssh-keygen -t ed25519 -f ~/.ssh/id_github -C "etlecoent@gmail.com" -N ""
    chmod 600 ~/.ssh/id_github
    chmod 644 ~/.ssh/id_github.pub

    echo ""
    echo "SSH key generated! Public key:"
    echo "---"
    cat ~/.ssh/id_github.pub
    echo "---"
    echo ""
    echo "Add this key to your GitHub account:"
    echo "https://github.com/settings/ssh/new"
    echo ""
    echo "Press Enter once you've added the key to GitHub..."
    read -r
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