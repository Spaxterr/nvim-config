source $HOME/antigen/antigen.zsh

# Standard Plugins
antigen bundle git
antigen bundle pip
antigen bundle command-not-found

# Custom Plugins
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle liquidprompt/liquidprompt
antigen bundle hlissner/zsh-autopair
antigen bundle zsh-users/zsh-autosuggestions

# Apply
antigen apply

source $HOME/.themes/powerline.theme
lp_theme powerline

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

fpath+=($HOME/.zsh/pure)

ZSH_THEME=""
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555588"
ZSH_AUTOSUGGEST_STRATEGY=(completion history)

plugins=(git z colorize docker git-commit pip ssh)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Aliases
alias ls="colorls -A --gs --sd"
alias cat="batcat -p"
alias dev="~/dev.sh"

# Start docker for WSL
if grep -q "microsoft" /proc/version > /dev/null 2>&1; then
    if service docker status 2>&1 | grep -q "is not running"; then
        wsl.exe --distribution "${WSL_DISTRO_NAME}" --user root \
            --exec /usr/sbin/service docker start > /dev/null 2>&1
    fi
fi

# Export root .env values
set -a
source .env
set +a

