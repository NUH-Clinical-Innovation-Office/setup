# Features

This repository contains a developer setup guide for MacOS, covering the installation and configuration of essential development tools.

## Setup Guide Features

| Feature | Status | Description |
|---|---|---|
| macOS Setup | stable | Full developer environment setup for macOS |
| Homebrew | stable | Package manager installation and configuration |
| GitHub CLI | stable | GitHub authentication and SSH key setup |
| Git Configuration | stable | Global git config with multi-profile support |
| Docker (OrbStack) | stable | Container runtime installation via OrbStack |
| Visual Studio Code | stable | VS Code installation with recommended extensions |
| Oh My Zsh | stable | Zsh framework with plugins (autosuggestions, syntax highlighting) |
| Node.js (nvm) | stable | Node version manager with auto-switching via .nvmrc/package.json |
| Python (pyenv) | stable | Python version manager with auto-switching via .python-version/pyproject.toml |
| Go (goenv) | stable | Go version manager with auto-switching via .go-version/go.mod |
| AI Tools Guide | stable | Documentation for Claude Code, Codex, and Alibaba Cloud Coding Plan |
| Privacy Guide | stable | Telemetry and data collection guidance for AI tools |
| Check Script | stable | Automated verification script (`check-script.sh`) |
| Shell Auto-switching | stable | Automatic version switching for Node.js, Python, and Go based on project files |
| Zsh Configuration | stable | Comprehensive .zshrc template with PATH, plugins, and aliases |

## Extension Recommendations

| Extension | Status | Description |
|---|---|---|
| Sublime Keybindings | stable | Enhanced keyboard shortcuts |
| Material Icon Theme | stable | File icons for VS Code |
| Prettier | stable | Code formatter |
| ESLint | stable | JavaScript/TypeScript linting |
| Prettier SQL | stable | SQL formatting |
| Ruff | stable | Python linting/formatting |
| Import Cost | stable | Bundle size display |
| Better Comments | stable | Colorful comment annotations |
| Auto Rename Tag | stable | HTML tag auto-renaming |
| Code Spell Checker | stable | Spell checking |
| GitLens | stable | Git blame and history |
| Git Graph | stable | Git commit graph visualization |
| Rainbow CSV | stable | CSV column highlighting |

## Supported Tools

| Tool | Version Manager | Auto-switch |
|---|---|---|
| Node.js | nvm | .nvmrc, package.json engines.node |
| Python | pyenv | .python-version, pyproject.toml, Pipfile |
| Go | goenv | .go-version, go.mod |

## Verification

Run the check script to verify your setup:

```bash
zsh <(curl -Ls https://raw.githubusercontent.com/NUH-Clinical-Innovation-Office/setup/main/check-script.sh)
```
