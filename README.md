# Dotfiles

Personal configuration files for **automated development environment setup**.

## Quick Start

On a new machine, run this single command for fully automated setup:

```bash
curl -fsSL https://raw.githubusercontent.com/etlecoent/dotfiles/main/install.sh | bash
```

This will **automatically**:
1. Clone this repository to `~/dotfiles`
2. Install Starship, Keychain, and Claude Code
3. Generate SSH key for GitHub (if not already present)
4. Set up all configurations and symlinks
5. Configure your shell environment

**Note:** When generating a new SSH key, you'll be prompted to add it to your GitHub account manually.

## What's Included

- **Zsh** - Shell configuration with aliases and functions
- **Starship** - Custom prompt
- **Git** - Global git configuration
- **SSH** - SSH configuration for GitHub
- **Claude Code** - AI coding assistant settings

## Manual Installation

```bash
git clone git@github.com:etlecoent/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash setup.sh
```

## Structure

```
dotfiles/
├── zsh/              # Zsh configuration (modular)
├── starship/         # Starship prompt config
├── ssh/              # SSH configuration
├── claude/           # Claude Code settings
├── gitconfig         # Git configuration
├── install.sh        # Installation script for new machines
└── setup.sh          # Setup script (installs and links)
```

## Customization

For machine-specific settings, create `zsh/private.zsh` (not tracked in git).
