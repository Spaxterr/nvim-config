# Lazy load jenv
nvm() {
    unset -f nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}

# Lazy load jenv
jenv() {
    unset -f jenv
    eval "$(command jenv init -)"
    jenv enable-plugin export
    jenv "$@"
}

# Lazy load bun completions
bun() {
    unset -f bun
    [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
    export BUN_INSTALL="$HOME/.bun"
    command bun "$@"
}


# fzf Options

fzf_config() {
    # History options
    setopt EXTENDED_HISTORY
    setopt SHARE_HISTORY
    setopt APPEND_HISTORY
    setopt INC_APPEND_HISTORY
    setopt HIST_EXPIRE_DUPS_FIRST
    setopt HIST_FIND_NO_DUPS
    setopt HIST_IGNORE_DUPS
    setopt HIST_IGNORE_ALL_DUPS
    setopt HIST_SAVE_NO_DUPS
    setopt HIST_IGNORE_SPACE
    setopt HIST_REDUCE_BLANKS

    HISTFILE=$HOME/.zsh_history
    HISTSIZE=100000
    SAVEHIST=100000

    # Enhanced fzf options
    export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:wrap --bind 'ctrl-y:execute-silent(echo {} | pbcopy)'"
    export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :100 {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git --exclude node_modules"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git --exclude node_modules"
    export FZF_DEFAULT_OPTS=" \
    --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
    --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
    --color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
    --color=selected-bg:#51576d \
    --multi \
    --height=80% \
    --layout=reverse \
    --border \
    --inline-info"
}

# Load antigen
if [[ -f $HOME/antigen/antigen.zsh ]]; then
    source $HOME/antigen/antigen.zsh

    antigen bundle command-not-found
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle unixorn/fzf-zsh-plugin@main
    antigen bundle agkozak/zsh-z
    antigen bundle hlissner/zsh-autopair

    antigen apply
fi

# Load starship
eval "$(starship init zsh)"

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fzf_config

# Basic configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555588"
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Additional useful options
setopt AUTO_CD                 # cd by typing directory name if not a command
setopt CORRECT                 # spell check commands
setopt COMPLETE_IN_WORD        # complete from both ends of a word
setopt ALWAYS_TO_END           # move cursor to end of word after completion
setopt PATH_DIRS               # perform path search even on command names with slashes
setopt AUTO_MENU               # show completion menu on second tab
setopt AUTO_LIST               # automatically list choices on ambiguous completion
setopt AUTO_PARAM_SLASH        # add trailing slash to directory names
setopt FLOW_CONTROL            # disable flow control (ctrl-s/ctrl-q)

# Aliases
alias ls="exa --color always --icons --all"
alias cat="batcat -p"
alias dev="~/dev.sh"

# Load NVM and enable the default LTS
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/nvm.sh" ] && nvm use default > /dev/null
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

start_docker_wsl() {
    if grep -qi "microsoft" /proc/version; then
        if ! pgrep -f docker > /dev/null; then
            wsl.exe --distribution "${WSL_DISTRO_NAME}" --user root \
                --exec /usr/sbin/service docker start > /dev/null 2>&1
        fi
    fi
}

# Call the function to check and start Docker if needed
start_docker_wsl

# Environment variables
set -a
[[ -f $HOME/.env ]] && . $HOME/.env
set +a

export TMPDIR="/tmp/"
export DOTNET_ROOT=$HOME/.dotnet

# PATH management (consolidated, organized, and consistent)
typeset -U path  # Remove duplicates and keep PATH and path array in sync


# Define all paths in your desired order of precedence
path=(
    "$HOME/.local/bin"
    "$HOME/.bun/bin"
    "$HOME/.dotnet/tools"
    "$HOME/.dotnet"
    "$HOME/.jenv/bin"
    "$HOME/go/bin"
    "/usr/local/go/bin"
    "/snap/bin"
    "/mnt/c/Win32Yank"
    "/opt/gradle/bin"
    $path # Appends the existing system path
)

# Key bindings
bindkey "^[[1;5C" forward-word          # Ctrl+Right
bindkey "^[[1;5D" backward-word         # Ctrl+Left
bindkey "^[[3~" delete-char             # Delete key
bindkey "^H" backward-delete-char       # Backspace
bindkey "^[[1~" beginning-of-line       # Home
bindkey "^[[4~" end-of-line             # End

# Additional exports
export PRETTIERD_DEFAULT_CONFIG="$HOME/.prettierrc"

# bun completions
[ -s "/home/developer/.bun/_bun" ] && source "/home/developer/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Launch tmux by default if available
if [[ -z "$TMUX" && -o interactive ]]; then tmux; fi

# pnpm
export PNPM_HOME="/home/developer/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
