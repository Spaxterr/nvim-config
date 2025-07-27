#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to add a line to a file if it doesn't already exist
append_if_missing() {
  local line="$1"
  local file="$2"
  grep -qF -- "$line" "$file" || echo "$line" >> "$file"
}

# Check for a package manager and set a variable
if command_exists apt; then
  PKG_MANAGER="apt"
elif command_exists pacman; then
  PKG_MANAGER="pacman"
else
  echo "Unsupported package manager. Please install dependencies manually."
  exit 1
fi

# --- 1. System Prerequisites ---
echo "> Installing system prerequisites..."
if [ "$PKG_MANAGER" = "apt" ]; then
  sudo apt update
  sudo apt install -y git curl build-essential zsh unzip
elif [ "$PKG_MANAGER" = "pacman" ]; then
  sudo pacman -Syu --noconfirm git curl base-devel zsh unzip
fi

# --- 2. Zsh and Oh My Zsh ---
if ! command_exists zsh; then
  echo "Zsh not found. Please install it first."
  exit 1
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "> Oh My Zsh not found. Installing..."
  # The --unattended flag prevents it from trying to change the shell and run zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "> Oh My Zsh is already installed."
fi

# Set Zsh as the default shell if it isn't already
if [[ "$SHELL" != *"zsh"* ]]; then
  echo "> Setting Zsh as the default shell..."
  chsh -s "$(which zsh)"
  echo "> Please log out and log back in for the shell change to take effect."
fi

# --- 3. Shell Tools and Plugins ---
echo "> Installing shell plugins and tools..."

# Antigen (Plugin Manager)
if [ ! -f "$HOME/antigen/antigen.zsh" ]; then
  echo "  - Antigen not found. Installing..."
  mkdir -p "$HOME/antigen/"
  curl -L git.io/antigen > "$HOME/antigen/antigen.zsh"
else
  echo "  - Antigen is already installed."
fi

# Liquidprompt
if [ ! -d "$HOME/liquidprompt" ]; then
  echo "  - Liquidprompt not found. Installing..."
  git clone https://github.com/nojhan/liquidprompt.git "$HOME/liquidprompt"
else
  echo "  - Liquidprompt is already installed."
fi

# Liquidprompt Theme
if [ ! -f "$HOME/.themes/powerline.theme" ]; then
    echo "  - Liquidprompt powerline theme not found. Installing..."
    mkdir -p "$HOME/.themes"
    curl -fsSL https://raw.githubusercontent.com/nojhan/liquidprompt/master/themes/powerline.theme -o "$HOME/.themes/powerline.theme"
fi

# fzf (Fuzzy Finder)
if [ ! -d "$HOME/.fzf" ]; then
  echo "  - fzf not found. Installing..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all --no-bash --no-fish
else
  echo "  - fzf is already installed."
fi

# --- 4. Core Command-Line Utilities (from .zshrc) ---
echo "> Installing command-line utilities..."

# Bat (cat clone)
if ! command_exists bat && ! command_exists batcat; then
  echo "  - bat not found. Installing..."
  if [ "$PKG_MANAGER" = "apt" ]; then
    sudo apt install -y bat
    # On Debian/Ubuntu, `bat` is installed as `batcat`
    # We create a link for consistency if it doesn't exist
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
  elif [ "$PKG_MANAGER" = "pacman" ]; then
    sudo pacman -S --noconfirm bat
  fi
else
  echo "  - bat is already installed."
fi

# Exa (ls replacement)
if ! command_exists exa; then
  echo "  - exa not found. Installing..."
  if ! command_exists cargo; then
    echo "    - Rust/Cargo not found. Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
  fi
  cargo install exa
else
  echo "  - exa is already installed."
fi

# ripgrep (rg)
if ! command_exists rg; then
  echo "  - ripgrep (rg) not found. Installing..."
  if [ "$PKG_MANAGER" = "apt" ]; then
    sudo apt install -y ripgrep
  elif [ "$PKG_MANAGER" = "pacman" ]; then
    sudo pacman -S --noconfirm ripgrep
  fi
else
  echo "  - ripgrep is already installed."
fi

# fd (find replacement)
if ! command_exists fd; then
  echo "  - fd-find (fd) not found. Installing..."
  if [ "$PKG_MANAGER" = "apt" ]; then
    sudo apt install -y fd-find
    # On Debian/Ubuntu, it's installed as `fdfind`, create a link
    ln -s $(which fdfind) ~/.local/bin/fd
  elif [ "$PKG_MANAGER" = "pacman" ]; then
    sudo pacman -S --noconfirm fd
  fi
else
  echo "  - fd is already installed."
fi

# tree
if ! command_exists tree; then
  echo "  - tree not found. Installing..."
  sudo ${PKG_MANAGER} install -y tree || sudo ${PKG_MANAGER} -S --noconfirm tree
fi

# --- 5. Tmux ---
echo "> Installing Tmux and TPM (Tmux Plugin Manager)..."
if ! command_exists tmux; then
  sudo ${PKG_MANAGER} install -y tmux || sudo ${PKG_MANAGER} -S --noconfirm tmux
fi

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "  - Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "  - Tmux Plugin Manager (tpm) is already installed."
fi

# --- 6. Language Version Managers and Runtimes ---
echo "> Installing language environments..."

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
  echo "  - nvm not found. Installing..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  # Source NVM to use it in the current script
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  echo "  - Installing latest LTS Node.js version..."
  nvm install --lts
  nvm alias default 'lts/*'
else
  echo "  - nvm is already installed."
fi

# jenv (Java Version Manager)
if [ ! -d "$HOME/.jenv" ]; then
  echo "  - jenv not found. Installing..."
  git clone https://github.com/jenv/jenv.git ~/.jenv
else
  echo "  - jenv is already installed."
fi

# bun
if ! command_exists bun; then
  echo "  - bun not found. Installing..."
  curl -fsSL https://bun.sh/install | bash
else
  echo "  - bun is already installed."
fi

# Go
if ! command_exists go; then
    echo "  - Go not found. Installing..."
    GO_VERSION="1.21.0" # You can change this to the latest version
    curl -L "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" -o "/tmp/go.tar.gz"
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf "/tmp/go.tar.gz"
    rm "/tmp/go.tar.gz"
    echo "  - Go installed. Add '/usr/local/go/bin' to your PATH in .zshrc."
fi


# --- 7. Nerd Fonts for Icons ---
echo "> Installing Nerd Fonts..."
if [ ! -f "$HOME/.local/share/fonts/FiraCodeNerdFont-Regular.ttf" ]; then
  echo "  - FiraCode Nerd Font not found. Installing..."
  mkdir -p ~/.local/share/fonts
  (
    cd ~/.local/share/fonts && \
    curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip && \
    unzip FiraCode.zip && \
    rm FiraCode.zip && \
    fc-cache -fv
  )
else
  echo "  - FiraCode Nerd Font is already installed."
fi


# --- Final Instructions ---
echo ""
echo "? Setup complete!"
echo ""
echo "--- IMPORTANT NEXT STEPS ---"
echo "1. Restart your terminal or log out and log back in for all changes to take effect."
echo "2. Open your terminal emulator's settings and change the font to 'FiraCode Nerd Font'."
echo "3. Run 'tmux' and press 'Prefix + I' (usually Ctrl+b + I) to install the TPM plugins from your .tmux.conf."
echo ""```
