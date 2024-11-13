#!/bin/bash

# Function to check command existence
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "oh-my-zsh not found. Installing..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Antigen
if [ ! -f "$HOME/antigen/antigen.zsh" ]; then
  echo "Antigen not found. Installing..."
  mkdir $HOME/antigen/
  curl -L git.io/antigen > "$HOME/antigen/antigen.zsh"
fi

# NVM (Node Version Manager)
if [ ! -d "$HOME/.nvm" ]; then
  echo "nvm not found. Installing..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
fi

# Batcat
if ! command_exists batcat; then
  echo "batcat not found. Installing..."
  if command_exists apt; then
    sudo apt update && sudo apt install -y bat
  else
    echo "Package manager not found. Please install bat manually."
  fi
fi

# Colorls
if ! command_exists colorls; then
  echo "colorls not found. Installing..."
  if command_exists gem; then
    sudo gem install colorls
  else
    echo "Ruby gem not found. Please install Ruby and try again."
  fi
fi

