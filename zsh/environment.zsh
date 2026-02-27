# Environment and Shell Settings

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Node Version Manager (nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Auto-load node version (use .nvmrc if present, otherwise use default)
if [ -f .nvmrc ]; then
  nvm use > /dev/null 2>&1
else
  nvm use default --silent > /dev/null 2>&1
fi

# uv shell completion
if command -v uv &> /dev/null; then
    eval "$(uv generate-shell-completion zsh)"
fi
if command -v uvx &> /dev/null; then
    eval "$(uvx --generate-shell-completion zsh)"
fi

# Starship prompt configuration
export STARSHIP_CONFIG="$HOME/dotfiles/starship/starship.toml"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY

# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Directory navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
