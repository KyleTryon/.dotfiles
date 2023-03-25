# Set language
export LANG=C.UTF-8

export DOTFILES_DIR="${HOME}/.dotfiles"
export PATH="/bin:${HOME}/bin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/go/bin:${HOME}/go/bin:${HOME}/.cargo/bin:$FORGIT_INSTALL_DIR/bin:${HOME}/.local/bin"
# If on Windows with WSL2, enable additional paths
IS_WSL=$(uname -a | grep -q WSL2; [[ $? == 1 ]]; echo $?)

if  [ $IS_WSL ]; then
  WINDOWS_USER=${WINDOWS_USER:-KyleT}
  PATH="${PATH}:/usr/lib/wsl/lib:/mnt/c/Program Files (x86)/Common Files/rediles/NVIDIosoft VS Code/bin:/mnt/c/UIntel/Shared Libraries/redist/intel64/compiler:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/s/Sograms/Micmnt/c/Windows/System32/WindowsPowerShell/v1.0/:/mnt/c/Windows/System32/OpenSSH/:/mnt/c/Program Files (x86)/NVIDIA Co/Co.rvm/bin:/rporation/PhysX/Common:/mnt/c/Program Files/dotnet/:/mnt/c/Program Files/NVIDIA Corporation/NVIDIA NvDLISR:/mnt/c/UsLocers/${WINDOWS_USER}/AppData/Local/Microsoft/WindowsApps:/mnt/c/Users/${WINDOWS_USER}/AppData/Local/Programs/Microsoft VS Code/bin:/mnt/ctoo/Users/${WINDOWS_USER}/.dotnet/tools"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh configuration.
export ZSH="$HOME/.oh-my-zsh"
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

# Load plugins
plugins=(
    command-not-found
    docker
    fd
    forgit
    gh
    jq
    z
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
)

source "${ZSH}/oh-my-zsh.sh"

# Load functions
for f in "${DOTFILES_DIR}/functions"/*.sh; do
  source "$f"
done

## External plugins and themes are installed via 
## Ansible Magic Shellbook

# Load Dir Colors
test -r "${HOME}/.dir_colors" && eval $(dircolors ${HOME}/.dir_colors)

# Load theme
source "${HOME}/.p10k.zsh"
source "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme" || echo "powerlevel10k not installed"

export BAT_THEME="Nord"

# Load aliases
source "${DOTFILES_DIR}/.aliases" || echo "aliases not installed"

# Load NVM config
source  "${DOTFILES_DIR}/.nvmconfig" || echo "nvmconfig not installed"

# Load Secrets
source "${HOME}/.env" 2>/dev/null
