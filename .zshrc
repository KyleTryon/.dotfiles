# Set language
export LANG=C.UTF-8

DOTFILES_DIR=${$HOME/.dotfiles}
ZPLUG_HOME=${$HOME/.zplug}
PATH=${$HOME/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/go/bin}

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode auto # update automatically without asking

setopt appendhistory
setopt autocd
setopt correct_all
setopt extendedglob
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt interactive_comments
setopt pushd_ignore_dups
setopt promptsubst

# Ignore interactive commands from history
export HISTORY_IGNORE="(ls|bg|fg|pwd|exit|cd ..|cd -|pushd|popd)"

# Load Zplug and plugins
source "${HOME}/.zplugrc"

# Load aliases
source "${DOTFILES_DIR}/.aliases"

# Load NVM config
source  "${DOTFILES_DIR}/.nvmconfig"

