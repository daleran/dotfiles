#!/bin/bash

# setup.sh - Environment installation script for Ubuntu
# Installs Fish, Neovim, Zellij, Yazi, Alacritty, Node, and more.

set -e

# --- Colors for output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Starting environment setup...${NC}"

# Check for Ubuntu
if ! grep -qi "ubuntu" /etc/os-release; then
    echo -e "${YELLOW}Warning: This script is optimized for Ubuntu. It may not work as expected on other distributions.${NC}"
fi

# 1. Base Utilities
echo -e "${YELLOW}📦 Installing base utilities...${NC}"
sudo apt update
sudo apt install -y \
    curl \
    git \
    stow \
    build-essential \
    unzip \
    python3-pip \
    python3-venv \
    pipx \
    software-properties-common \
    fzf \
    ripgrep \
    fd-find \
    libevent-dev \
    ncurses-dev \
    pkg-config \
    postgresql-client \
    libpq-dev \
    iproute2 \
    gh \
    php-cli \
    php-curl \
    php-mbstring \
    php-xml \
    php-sqlite3 \
    php-pgsql

pipx ensurepath

# 2. Add PPAs
echo -e "${YELLOW}📂 Adding PPAs for latest versions...${NC}"
sudo add-apt-repository -y ppa:fish-shell/release-3
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update

# 3. Install core tools
echo -e "${YELLOW}🛠️ Installing Fish, Neovim, and Alacritty...${NC}"
sudo apt install -y fish neovim alacritty

# 4. Local bin setup
mkdir -p "$HOME/.local/bin"

# 5. Zellij Installation
if ! command -v zellij &> /dev/null; then
    echo -e "${YELLOW}📥 Installing Zellij...${NC}"
    curl -L https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz | tar xz
    mv zellij "$HOME/.local/bin/"
fi

# 6. Yazi Installation
if ! command -v yazi &> /dev/null; then
    echo -e "${YELLOW}📥 Installing Yazi...${NC}"
    TEMP_DIR=$(mktemp -d)
    curl -L -o "$TEMP_DIR/yazi.zip" https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip
    unzip "$TEMP_DIR/yazi.zip" -d "$TEMP_DIR"
    mv "$TEMP_DIR"/yazi-x86_64-unknown-linux-gnu/yazi "$HOME/.local/bin/"
    mv "$TEMP_DIR"/yazi-x86_64-unknown-linux-gnu/ya "$HOME/.local/bin/"
    rm -rf "$TEMP_DIR"
fi

# 7. NVM & Node 22
if [ ! -d "$HOME/.nvm" ]; then
    echo -e "${YELLOW}📦 Installing NVM...${NC}"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

echo -e "${YELLOW}🟢 Installing Node 22...${NC}"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 22
nvm use 22
nvm alias default 22

# 8. Claude CLI
echo -e "${YELLOW}🤖 Installing Claude CLI...${NC}"
npm install -g @anthropic-ai/claude-code

# 9. Composer Installation
if ! command -v composer &> /dev/null; then
    echo -e "${YELLOW}🎼 Installing Composer...${NC}"
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
fi

# 10. Pgcli
if ! command -v pgcli &> /dev/null; then
    echo -e "${YELLOW}🐘 Installing pgcli...${NC}"
    pipx install pgcli
fi

# 11. JetBrainsMono Nerd Font
FONT_DIR="$HOME/.local/share/fonts"
if [ ! -d "$FONT_DIR/JetBrainsMono" ]; then
    echo -e "${YELLOW}🔡 Installing JetBrainsMono Nerd Font...${NC}"
    mkdir -p "$FONT_DIR/JetBrainsMono"
    TEMP_DIR=$(mktemp -d)
    curl -L -o "$TEMP_DIR/jbm.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip "$TEMP_DIR/jbm.zip" -d "$FONT_DIR/JetBrainsMono"
    rm -rf "$TEMP_DIR"
    fc-cache -fv
fi

# 12. Stow dotfiles
echo -e "${YELLOW}🔗 Stowing dotfiles...${NC}"
cd "$(dirname "$0")"
stow alacritty claude fish gemini nvim yazi zellij

# 13. Setup Fish shell as default
if [[ "$SHELL" != *"fish"* ]]; then
    echo -e "${YELLOW}🐚 Changing default shell to fish...${NC}"
    sudo chsh -s "$(which fish)" "$USER"
fi

# 14. Install Fisher and plugins
echo -e "${YELLOW}🐟 Installing Fisher and plugins...${NC}"
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && fisher update"

echo -e "${GREEN}✅ Setup complete!${NC}"
echo -e "${GREEN}Please log out and log back in (or restart your terminal) for all changes to take effect.${NC}"
