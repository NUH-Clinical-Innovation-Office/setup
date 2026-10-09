#!/usr/bin/env bash

# Copyright 2026 NUH Department of Medicine
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ============================================
# Terminal Environment Checker
# Checks if essential tools from the README are installed
# For macOS only
# ============================================

echo "🔎 Checking your terminal setup..."

# Initialize status tracker
all_ok=true

# -------------------------------
# Helper function to check commands
# -------------------------------
check_command() {
  if command -v "$1" >/dev/null 2>&1; then
    echo -e "\033[0;32m✅ $1 is installed\033[0m"
  else
    echo -e "\033[0;31m❌ $1 is NOT installed\033[0m"
    all_ok=false
  fi
}

# -------------------------------
# Check CLI tools
# -------------------------------
echo ""
echo "💻 Checking command line tools..."
check_command xcode-select
check_command brew
check_command git
check_command gh
check_command wget
check_command jq
check_command openssl
check_command code
check_command zsh

# -------------------------------
# Check Oh My Zsh plugins
# -------------------------------
echo ""
echo "🌀 Checking Oh My Zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
ZSH_DIR="${ZSH_DIR:-$HOME/.oh-my-zsh}"

plugins=(
  git gitfast last-working-dir common-aliases
  history-substring-search zsh-autosuggestions zsh-syntax-highlighting
)

for plugin in "${plugins[@]}"; do
  if [ -d "$ZSH_CUSTOM/plugins/$plugin" ] || [ -d "$ZSH_DIR/plugins/$plugin" ]; then
    echo "✅ Oh My Zsh plugin $plugin installed"
  else
    echo "❌ Oh My Zsh plugin $plugin NOT installed"
    all_ok=false
  fi
done

# -------------------------------
# Docker & Docker Compose check
# -------------------------------
echo ""
echo "🐳 Checking Docker and Docker Compose..."

if command -v docker >/dev/null 2>&1; then
  DOCKER_VER=$(docker --version)
  echo -e "\033[0;32m✅ Docker is installed: $DOCKER_VER\033[0m"
else
  echo -e "\033[0;31m❌ Docker is NOT installed (brew install colima docker)\033[0m"
  all_ok=false
fi

if docker compose version >/dev/null 2>&1; then
  COMPOSE_VER=$(docker compose version)
  echo -e "\033[0;32m✅ Docker Compose is installed: $COMPOSE_VER\033[0m"
else
  echo -e "\033[0;31m❌ Docker Compose is NOT available (brew install docker-compose, then set cliPluginsExtraDirs)\033[0m"
  all_ok=false
fi

# -------------------------------
# Load mise-managed tools
# -------------------------------
if command -v mise >/dev/null 2>&1; then
  eval "$(mise env -s zsh)"
fi

# -------------------------------
# Node, Bun, Python, Go & Java check (zsh-safe)
# -------------------------------
echo ""
echo "🔧 Checking mise, Node.js, Bun, Python, Go, and Java versions..."

if command -v mise >/dev/null 2>&1; then
  MISE_VER=$(mise --version 2>/dev/null)
  echo -e "\033[0;32m✅ mise is installed, version: $MISE_VER\033[0m"
else
  echo -e "\033[0;31m❌ mise is NOT installed\033[0m"
  all_ok=false
fi

# Node.js
if command -v node >/dev/null 2>&1; then
  NODE_VER=$(node -v)
  echo -e "\033[0;32m✅ Node.js is installed, version: $NODE_VER\033[0m"
else
  echo -e "\033[0;31m❌ Node.js is NOT installed (mise use -g node@24)\033[0m"
  all_ok=false
fi

# Bun
if command -v bun >/dev/null 2>&1; then
  BUN_VER=$(bun -v)
  echo -e "\033[0;32m✅ Bun is installed, version: $BUN_VER\033[0m"
else
  echo -e "\033[0;31m❌ Bun is NOT installed (mise use -g bun@1)\033[0m"
  all_ok=false
fi

# Python
if command -v python >/dev/null 2>&1; then
  PY_VER=$(python -V 2>&1)
  echo -e "\033[0;32m✅ Python is installed, version: $PY_VER\033[0m"
else
  echo -e "\033[0;31m❌ Python is NOT installed (mise use -g python@3.12)\033[0m"
  all_ok=false
fi

# Go
if command -v go >/dev/null 2>&1; then
  GO_VER=$(go version)
  echo -e "\033[0;32m✅ Go is installed, version: $GO_VER\033[0m"
else
  echo -e "\033[0;31m❌ Go is NOT installed (mise use -g go@1.24)\033[0m"
  all_ok=false
fi

# Java
if command -v java >/dev/null 2>&1; then
  JAVA_VER=$(java -version 2>&1 | head -n1)
  echo -e "\033[0;32m✅ Java is installed, version: $JAVA_VER\033[0m"
else
  echo -e "\033[0;31m❌ Java is NOT installed (mise use -g java@temurin-25)\033[0m"
  all_ok=false
fi

# -------------------------------
# Check VS Code extensions
# -------------------------------
echo ""
echo "🛠 Checking VS Code extensions..."
vscode_extensions=(
  ms-vscode.sublime-keybindings
  PKief.material-icon-theme
  esbenp.prettier-vscode
  dbaeumer.vscode-eslint
  inferrinizzard.prettier-sql-vscode
  charliermarsh.ruff
  wix.vscode-import-cost
  aaron-bond.better-comments
  formulahendry.auto-rename-tag
  streetsidesoftware.code-spell-checker
  eamodio.gitlens
  mhutchie.git-graph
  mechatroner.rainbow-csv
)

# Get all installed extensions once to avoid SIGPIPE errors
installed_extensions=$(code --list-extensions 2>/dev/null || echo "")

for ext in "${vscode_extensions[@]}"; do
  if echo "$installed_extensions" | grep -qi "^${ext}$"; then
    echo "✅ VS Code extension $ext installed"
  else
    echo "❌ VS Code extension $ext NOT installed"
    all_ok=false
  fi
done

# -------------------------------
# Git & GitHub auth check
# -------------------------------
echo ""
echo "📝 Checking Git and GitHub CLI authentication..."

if command -v git >/dev/null 2>&1; then
  GIT_VER=$(git --version)
  echo -e "\033[0;32m✅ Git is installed: $GIT_VER\033[0m"
else
  echo -e "\033[0;31m❌ Git is NOT installed\033[0m"
  all_ok=false
fi

if command -v gh >/dev/null 2>&1; then
  if gh auth status >/dev/null 2>&1; then
    echo -e "\033[0;32m✅ GitHub CLI is authenticated\033[0m"
  else
    echo -e "\033[0;31m❌ GitHub CLI is NOT authenticated\033[0m"
    all_ok=false
  fi
else
  echo -e "\033[0;31m❌ GitHub CLI (gh) is NOT installed, cannot check authentication\033[0m"
  all_ok=false
fi

# -------------------------------
# Final summary with colors
# -------------------------------
echo ""
if [ "$all_ok" = true ]; then
  echo -e "\033[0;32m🎉 Everything is properly installed! Your terminal is ready.\033[0m"
else
  echo -e "\033[0;31m⚠️ Some items are missing or not properly installed. Please check the messages above.\033[0m"
fi
