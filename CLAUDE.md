# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a personal dotfiles repository for managing configuration files across machines. It contains:
- Git configuration (`gitconfig`)
- SSH configuration (`ssh/config`)
- Zsh shell configuration (`zsh/`)
- Claude Code settings and customizations (`claude/`)

## Setup and Installation

The repository uses symbolic links and configuration files to install dotfiles. Run the setup script:
```bash
bash setup.sh
```

This creates:
- `~/.zshenv` file that sources `~/dotfiles/zsh/zshrc`
- Symlinks for SSH, Git, and Claude configurations

**Prerequisites** (install manually if needed):
- Starship prompt: `curl -sS https://starship.rs/install.sh | sh`
- Keychain for SSH: `sudo apt install keychain`

## Architecture

### Zsh Configuration
The `zsh/` directory contains a modular shell configuration:
- **zshrc**: Main configuration file (sourced by `~/.zshenv`)
- **environment.zsh**: Shell options, history settings, and completion
- **aliases.zsh**: Command aliases (git, navigation, safety)
- **functions.zsh**: Utility functions (mkcd, extract, ff, fd)
- **private.zsh**: Optional file for machine-specific settings (not tracked in git)

The setup uses `.zshenv` as an entry point that sources the dotfiles configuration, keeping all actual configuration in the repository.

### Claude Configuration
The `claude/` directory contains Claude Code customizations:
- **settings.json**: Claude Code settings including:
  - Model selection (opusplan)
  - Permissions deny-list for sensitive operations
  - Custom statusline configuration
- **statusline.sh**: Bash script that generates custom statusline showing version, model, context usage, current directory, and git branch
- **CLAUDE.md**: Global instructions for Claude Code (symlinked to `~/.claude/`)

### Git Configuration
- User identity configured for Étienne Le Coënt
- Default branch: `main`

### SSH Configuration
- GitHub SSH key: Uses `~/.ssh/id_github` for github.com connections
- Keychain integration for automatic SSH key loading (configured in zshrc)

## Important Notes

- When modifying configuration files, changes should be made in this repository, not in the home directory symlinks
- For machine-specific zsh settings, create `zsh/private.zsh` (automatically sourced if present, not tracked in git)
- Configuration follows conventional commit format for version control
