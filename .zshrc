bash -e $HOME/setup.sh
source $HOME/antigen/antigen.zsh

# Standard Plugins
antigen bundle git
antigen bundle pip
antigen bundle ssh
antigen bundle command-not-found

# Custom Plugins
antigen bundle unixorn/fzf-zsh-plugin@main
antigen bundle agkozak/zsh-z
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle liquidprompt/liquidprompt
antigen bundle hlissner/zsh-autopair
antigen bundle zsh-users/zsh-autosuggestions

# Apply
antigen apply

source $HOME/.themes/powerline.theme
lp_theme powerline

export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

# FZF Theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
--color=selected-bg:#51576d \
--multi"

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

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
jenv enable-plugin export

# Export root .env values
set -a
source $HOME/.env
set +a

