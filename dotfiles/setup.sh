#!/bin/bash

set -e 

echo "** Starting MAC bootstrap.."

#-----------------------
# 1. Homebrew 
#-----------------------
if ! command -v brew > /dev/null 2>&1; then
  echo " Installing Homebrew.."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add brew to PATH (Apple Silicon)
  if [[ -d /opt/homebrew/bin ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo " Homebrew already installed.."
fi 

brew update

# -------------------------------------------------
# Zsh + powerlevel10k + plugins
# -------------------------------------------------
echo "** Setting up zsh environment..."

ZSH_DIR="$HOME/.zsh"

mkdir -p "$ZSH_DIR"

# powerlevel10k
if [[ ! -d "$ZSH_DIR/powerlevel10k" ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_DIR/powerlevel10k"
else
  echo " powerlevel10k already installed"
fi

# zsh-autosuggestions
if [[ ! -d "$ZSH_DIR/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_DIR/zsh-autosuggestions"
else
  echo " zsh-autosuggestions already installed"
fi

# zsh-syntax-highlighting
if [[ ! -d "$ZSH_DIR/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_DIR/zsh-syntax-highlighting"
else
  echo " zsh-syntax-highlighting already installed"
fi

# Source additions safely
ZSHRC="$HOME/.zshrc"
INCLUDE_LINE='source ~/dotfiles/zsh/zsh-additions.sh'

if ! grep -q "$INCLUDE_LINE" "$ZSHRC" 2>/dev/null; then
  echo "" >> "$ZSHRC"
  echo "# Bootstrap additions" >> "$ZSHRC"
  echo "$INCLUDE_LINE" >> "$ZSHRC"
fi

#--------------------------
# 2. Git
#--------------------------

if ! command -v git > /dev/null 2>&1; then
  echo "** Installing Git.."
  brew install git
else
  echo " Git already installed.."
fi

CURRENT_NAME=$(git config --global user.name || true)
CURRENT_EMAIL=$(git config --global user.email || true)

if [[ -n "$CURRENT_NAME" && -n "$CURRENT_EMAIL" ]];then
  echo "Current Git identity:"
  echo "  Name : $CURRENT_NAME"
  echo "  Email: $CURRENT_EMAIL"
  echo ""
  
  read -p "Do you want to edit Git user.name and user.email? (y/N): " CONFIRM
  if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
    read -p "New Git user.name: " NEW_NAME
    read -p "New Git user.email: " NEW_EMAIL
   
    git config --global user.email "$NEW_EMAIL"
    git config --global user.name "$NEW_NAME"
    echo " Git identity updated.."
  else
    echo " Keeping existing Git configuration.."
  fi
else
  echo "** Configuring Git..."

  read -p "Git user.name: " GIT_NAME
  read -p "Git user.email: " GIT_EMAIL

  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"
  git config --global core.editor "vim"
  git config --global init.defaultBranch main

  echo "** Git configured"
fi

# -------------------------------------------------
# 3. kubectl
# -------------------------------------------------
if ! command -v kubectl > /dev/null 2>&1; then
  echo "** Installing kubectl"
  brew install kubectl
else
  echo " kubectl already installed.."
fi

# -------------------------------------------------
# 3. kubectx
# -------------------------------------------------
if ! command -v kubectx > /dev/null 2>&1; then
  echo "** Installing kubectx"
  brew install kubectx
else
  echo " kubectx already installed.."
fi


# -------------------------------------------------
# 3. awscli
# -------------------------------------------------
if ! command -v aws > /dev/null 2>&1; then
  echo "** Installing awscli"
  brew install awscli
else
  echo " awscli already installed.."
fi

# -------------------------------------------------
# 4. iTerm2
# -------------------------------------------------
if [[ ! -d "/Applications/iTerm.app" ]]; then
  echo "** Installing iTerm2..."
  brew install --cask iterm2
else
  echo " iTerm2 already installed"
fi

echo ""
echo "** Mac bootstrap completed successfully."
echo "** All required utilities for iterm2 is installed and configured in ~/.zshrc"
echo "** Next: open iTerm2 and continue shell advance setup using p10k configure"


