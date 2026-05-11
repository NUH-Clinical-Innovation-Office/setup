# Features

This document describes the features of the setup repository.

## Feature Inventory

| Feature                                      | Status | Description                                                                                      |
| -------------------------------------------- | ------ | ------------------------------------------------------------------------------------------------ |
| macOS Development Setup                     | stable | Comprehensive macOS development environment setup guide                                          |
| Command Line Tools Installation              | stable | Installs xcode-select, brew, git, gh, wget, jq, openssl                                          |
| VS Code Configuration                       | stable | VS Code and Cursor editor setup with extensions                                                 |
| Shell Configuration (Oh My Zsh)             | stable | Zsh with Oh My Zsh framework and plugins (git, autosuggestions, syntax highlighting, etc.)      |
| GitHub CLI Authentication                   | stable | SSH-based GitHub CLI authentication                                                               |
| Docker (OrbStack) Installation              | stable | OrbStack installation and verification as Docker alternative                                     |
| Node.js via nvm                             | stable | Node.js version manager with automatic version switching via .nvmrc/package.json                 |
| Python via pyenv                            | stable | Python version manager with automatic version switching via .python-version/pyproject.toml       |
| Go via goenv                                | stable | Go version manager with automatic version switching via .go-version/go.mod                        |
| Setup Verification Script                    | stable | Automated check-script.sh to verify all installed components                                     |
| AI Tools Guidance                           | stable | Documentation for Claude Code, OpenAI Codex, and Alibaba Cloud Coding Plan                      |
| Privacy & Telemetry Documentation           | stable | Guidance on disabling telemetry in VSCode and privacy considerations for AI tools                |

## Tool Versions Referenced

The following tool versions are referenced in this setup:

| Tool        | Version  | Source                          |
| ----------- | -------- | ------------------------------- |
| nvm         | 0.40.4   | check-script.sh                 |
| Node.js     | 24       | README.md                       |
| Python      | 3.12     | README.md                       |
| Go          | 1.24.0   | README.md                       |
| macOS       | -        | README.md (macOS only guide)    |