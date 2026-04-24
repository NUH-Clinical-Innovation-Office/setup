# Features

This document describes the features available in the setup guide.

## Feature Inventory

| Feature                       | Status  | Description                                                              |
| ----------------------------- | ------- | ------------------------------------------------------------------------ |
| nvm (Node.js version manager) | stable  | Install and manage multiple Node.js versions with auto-switching         |
| pyenv (Python version manager)| stable  | Install and manage multiple Python versions with auto-switching           |
| goenv (Go version manager)    | stable  | Install and manage multiple Go versions with auto-switching               |
| OrbStack (Docker alternative) | stable  | Lightweight Docker alternative with better performance on macOS            |
| Oh My Zsh                     | stable  | Zsh framework with plugins for git, syntax highlighting, autosuggestions |
| VS Code Extensions            | stable  | Curated set of extensions for productivity, formatting, and git tools    |
| Check Script                  | stable  | Verification script to validate complete setup installation               |
| GitHub CLI                    | stable  | Command-line tool for GitHub operations with SSH authentication          |
| Homebrew                      | stable  | Package manager for macOS/Linux                                          |
| Alibaba Cloud Coding Plan     | stable  | Alternative API endpoint integration for cost savings                    |

## Auto-Version Switching

The setup configures automatic version switching for each language runtime:

- **Node.js**: Reads `.nvmrc` or `package.json` `engines.node` when entering a directory
- **Python**: Reads `.python-version`, `pyproject.toml`, or `Pipfile` when entering a directory
- **Go**: Reads `.go-version` or `go.mod` `go` directive when entering a directory

## Verification

Run the check script to verify your setup:

```bash
zsh <(curl -Ls https://raw.githubusercontent.com/NUH-Clinical-Innovation-Office/setup/main/check-script.sh)
```

Expected output: `🎉 Everything is properly installed! Your terminal is ready.`