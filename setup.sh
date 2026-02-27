#!/bin/bash

set -e

echo "==> Installing Starship prompt..."
if command -v starship &> /dev/null; then
    echo "Starship already installed"
else
    curl -sS https://starship.rs/install.sh | sh
fi

echo ""
echo "==> Installing system dependencies (requires sudo)..."
sudo apt update
sudo apt install -y libatomic1 keychain libxml2-dev libxslt1-dev build-essential

echo ""
echo "==> Installing Claude Code..."
if command -v claude &> /dev/null; then
    echo "Claude Code already installed"
else
    curl -fsSL https://claude.ai/install.sh | bash
fi

echo ""
echo "==> Installing nvm (Node Version Manager)..."
if [ -d ~/.nvm ]; then
    echo "nvm already installed"
else
    PROFILE=/dev/null curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

echo ""
echo "==> Installing Node.js LTS via nvm..."
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
if command -v nvm &> /dev/null; then
    nvm install --lts
    nvm alias default 'lts/*'
    echo "Node.js LTS installed: $(node --version)"
else
    echo "Warning: nvm not available, skipping Node.js installation"
fi

echo ""
echo "==> Installing Playwright CLI..."
if command -v playwright-cli &> /dev/null; then
    echo "Playwright CLI already installed"
else
    npm install -g @playwright/cli@latest
    playwright-cli install --skills
    npx playwright install-deps chromium
fi

echo ""
echo "==> Installing uv (Python package manager)..."
if command -v uv &> /dev/null; then
    echo "uv already installed"
else
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

echo ""
echo "==> Installing Python LTS via uv..."
if command -v uv &> /dev/null || [ -f "$HOME/.local/bin/uv" ]; then
    export PATH="$HOME/.local/bin:$PATH"
    uv python install
    echo "Python installed: $(uv python find)"
else
    echo "Warning: uv not available, skipping Python installation"
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