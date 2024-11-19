# Lazy load nvm
nvm() {
  unset -f nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  nvm "$@"
}

# Lazy load jenv
jenv() {
  unset -f jenv
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(command jenv init -)"
  jenv enable-plugin export
  jenv "$@"
}


# fzf Options

fzf_config() {
    setopt EXTENDED_HISTORY
    setopt SHARE_HISTORY
    setopt APPEND_HISTORY
    setopt INC_APPEND_HISTORY
    setopt HIST_EXPIRE_DUPS_FIRST
    setopt HIST_FIND_NO_DUPS
    setopt HIST_IGNORE_DUPS
    setopt HIST_IGNORE_ALL_DUPS
    setopt HIST_SAVE_NO_DUPS

    HISTFILE=~/.zsh_history
    HISTSIZE=100000   # In-memory history
    SAVEHIST=100000   # Saved to file
    export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:wrap"
    export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
    export FZF_DEFAULT_OPTS=" \
    --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
    --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
    --color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
    --color=selected-bg:#51576d \
    --multi"
}

# Load antigen
source $HOME/antigen/antigen.zsh

# Essential plugins only
antigen bundle git
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Custom Plugins
antigen bundle unixorn/fzf-zsh-plugin@main
antigen bundle agkozak/zsh-z
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle hlissner/zsh-autopair
antigen bundle zsh-users/zsh-autosuggestions

[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt

antigen apply

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fzf_config

# Powerline theme for liquidprompt
source $HOME/.themes/powerline.theme
lp_theme powerline

# Basic configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555588"
ZSH_AUTOSUGGEST_STRATEGY=(completion history)

# Aliases
alias ls="colorls -A --gs --sd"
alias cat="batcat -p"
alias dev="~/dev.sh"

# WSL Docker check (only if in WSL environment)
if grep -q "microsoft" /proc/version &>/dev/null; then
  if ! pgrep -f docker &>/dev/null; then
    wsl.exe --distribution "${WSL_DISTRO_NAME}" --user root \
      --exec /usr/sbin/service docker start &>/dev/null
  fi
fi

# Load environment variables
[[ -f $HOME/.env ]] && source $HOME/.env

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
