# Setup Guide

The current setup guide will be for MacOS only. If you are using any other OS please contact Yong Cheng for custom instructions.

Read the instructions carefully before executing any commands. In general it is important that you understand of you are installing and how it will help with your local development.

## Table of Contents

- [GitHub account](#github-account)
- [Command Line Tools](#command-line-tools)
- [Homebrew](#homebrew)
- [Visual Studio Code (VS Code)](#visual-studio-code-vs-code)
- [Shell configuration](#shell-configuration)
- [GitHub](#github)
- [Git](#git)
- [Programming Languages](#programming-languages)
  - [Node.js](#nodejs)
    - [Auto adjusting node version base on repository](#auto-adjusting-node-version-base-on-repository)
  - [Python](#python)
    - [Auto adjusting Python version based on repository](#auto-adjusting-python-version-based-on-repository)
- [Check Setup](#check-setup)
- [AI Tools](#ai-tools)
  - [Privacy Considerations by Tool](#privacy-considerations-by-tool)
  - [Disabling VSCode Telemetry](#disabling-vscode-telemetry)
  - [Recommendations](#recommendations)
  - [Personal Notes](#personal-notes)
- [License](#license)

## GitHub account

**[Sign up](https://github.com/join)** for a GitHub account if you don't already have one

**[Enable Two-Factor Authentication (2FA)](https://docs.github.com/en/authentication/securing-your-account-with-two-factor-authentication-2fa/configuring-two-factor-authentication#configuring-two-factor-authentication-using-text-messages)** on GitHub to protect your account. It adds an extra layer of security, ensuring that even if someone knows your password, only you can log in.

## Command Line Tools

The terminal is an application that you will be using frequently. We expect you to master the usage. To open the terminal you can do so through applications or simply press `Command` + `Space` which will trigger spotlight search and search for "Terminal"

Open the terminal, copy and paste the following command and hit `Enter`:

```bash
xcode-select --install
```

If you see a message such as `command line tools are already installed`, **skip to the next step**

A window will open asking you to install the software. Click on `install` and wait until everything is installed.

## Homebrew

[Homebrew](http://brew.sh/) is a package manager for MacOS (and Linux), if you are using windows you should not be following this guide. If you have already installed it, you are good.

To install it, open a terminal and run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

If being asked for your confirmation hit `Enter` and if it prompts you for your password you should enter your Mac's user account password (the one you use to login) and press `Enter`

⚠️ Note that when you type your password, nothing will show up on the screen. This is a security feature to prevent people from seeing your password and its length.

After the installation read the messages in the terminal. If there are any warnings, execute the commands in the next steps section in the terminal. A sample next steps is shown below. If you have no warnings, you can move on to the next step

```bash
# ⚠️ Sample only, DO NOT EXECUTE
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Run the following commands in the terminal to install the relevant libraries:

```bash
brew update
brew upgrade git || brew install git                  # Git version control
brew upgrade gh || brew install gh                    # GitHub CLI
brew upgrade wget || brew install wget                # Download files from the web
brew upgrade jq || brew install jq                    # JSON processor
brew upgrade openssl || brew install openssl          # SSL/TLS cryptography library
```

## Visual Studio Code (VS Code)

You can also use [Cursor](https://cursor.com) instead of VS Code. However, do take note that not all organizations allow the use of Cursor. The choice is yours.

Run the following command in the terminal:

```bash
brew install --cask visual-studio-code
```

Launch VSCode by running the following command in the terminal:

```bash
code
```

We will install some useful VS Code extensions through the terminal. If you already know what you are doing here you can skip this step, or you can also pick and choose to install the extensions that you want.

```bash
# Keybindings & Themes
code --install-extension ms-vscode.sublime-keybindings         # Enhance key bindings
code --install-extension PKief.material-icon-theme             # Icon theme for files

# Formatting & Linting
code --install-extension esbenp.prettier-vscode                # Prettier formatter plugin
code --install-extension dbaeumer.vscode-eslint                # ESLint checker
code --install-extension inferrinizzard.prettier-sql-vscode    # SQL formatter
code --install-extension charliermarsh.ruff                    # Python formatter (Ruff)

# Productivity & Code Quality
code --install-extension wix.vscode-import-cost                # View import cost
code --install-extension aaron-bond.better-comments            # Colorful comment annotations
code --install-extension formulahendry.auto-rename-tag         # Auto-rename paired HTML tags
code --install-extension streetsidesoftware.code-spell-checker # Spell checker

# Git Tools
code --install-extension eamodio.gitlens                       # Git blame & history insights
code --install-extension mhutchie.git-graph                    # Git commit graph viewer

# Data Handling
code --install-extension mechatroner.rainbow-csv               # Colorful CSV column highlighting
```

## Shell configuration

If you already have your own shell configuration, you can skip this step. If you have no idea what I am talking about, then you can proceed to install the `zsh` plugin [Oh My Zsh](https://ohmyz.sh/). Execute the following in the terminal

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

If asked "Do you want to change ....", press `Y`

Once the extension is installed we are going to be configuring it for optimal usage. Run the following command in the terminal

```bash
code ~/.zshrc
```

This should open up the `.zshrc` file in vscode. Then ensure that it contains the following lines

```zsh
# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Useful oh-my-zsh plugins
# git plugin is to allow for shortcuts
# gitfast plugin makes git completions faster
# last-working-dir remembers the last working directory you are in
# common-aliases adds shortcuts such as ll and la
# zsh-syntax-highlighting allows for coloured syntax
# history-substring-search allow for substring search via up and down arrow keys
# zsh-autosuggestions is like an autocomplete of the last command used press right arrow key to complete it
plugins=(git gitfast last-working-dir common-aliases history-substring-search zsh-autosuggestions zsh-syntax-highlighting)

# (MacOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# Disable warning about insecure completion-dependent directories
ZSH_DISABLE_COMPFIX=true

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Default language for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Default code editor
export BUNDLER_EDITOR=code
export EDITOR="code --wait"
```

After making the adjustment, save the file. Go back to your terminal and run the following

```bash
exec zsh # restart the terminal with the updated zsh configs
```

You will see errors or warnings, regarding zsh-autosuggestions and zsh-syntax-highlighting plugin not being installed. Install them

```bash
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

```

## GitHub

In order to ensure that we can connect to GitHub using the terminal we will need to do the following. If you already have GitHub connected to your terminal you can skip this section.

If you are unsure you can run the following command to check if gh is setup.

```bash
gh auth status

# You should see something like "Logged in to github.com account"
```

Login by copy and pasting the following command into your terminal. Please note that you **SHOULD NOT edit the `user` or `email`** and for this section **FOLLOW the instructions very carefully**

```bash
gh auth login -s 'user:email' -w --git-protocol ssh
```

You will be asked a few questions:

1. `Generate a new SSH key to add to your GitHub account?` Press `Enter` so that ssh keys will be generated for you

If you already have SSH keys, you will be shown `Upload your SSH public key to your GitHub account?`. Using the arrow keys, select your public key and press `Enter`.

2. `Enter a passphrase for your new SSH key (Optional)`. Type something you want and that you'll remember. It's a password to protect your private key stored on your hard drive. Then press `Enter`.

3. `Title for your SSH key`. You can used the default by just pressing `Enter`.

You will then get the following output:

```bash
! First copy your one-time code: XXXX-XXXX
- Press Enter to open github.com in your browser...
```

Select and copy the code (`XXXX-XXXX`), then press `Enter`.

A browser will open up and asking you to authorize GitHub CLI and you will be required to past the code. Accept it. Ensure that the page is reloaded and the authorization is successful before returning to the terminal.

Go back to your terminal, you should see something along the lines of authorization being successful. Press `Enter`.

To check that you are properly connected, copy and paste the following in the terminal:

```bash
gh auth status

# You should see something like "Logged in to github.com account"
```

## Git

Make sure your global Git username and email are configured if you want to use them. However, if you manage multiple Git profiles (for example, personal and work), I feel that it is better not to set a global configuration. This helps prevent accidentally committing to your company repository using your personal email especially if you use the same laptop for both work and personal projects. If you are only using git on this laptop for one use case then run the following command to set the following.

```bash
# ⚠️ Remember to change "Your Name" "your@email.com" accordingly
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

To check your settings, run the following in the terminal

```bash
git config --global --list
```

If you want to change things locally instead of globally use `--local` instead.

## Programming Languages

Within an organization, you will often work with multiple programming languages. It is important to install each language using a version manager to ensure consistency and avoid conflicts between projects. If you already have your own preferred language version manager, go ahead and user it. However, if you have no idea you can install the following depending on the programming language you are using.

If you are working in NUH Clinical Innovation Office, install all of the below.

## Node.js

For Node.js we will use [nvm](https://github.com/nvm-sh/nvm) as our version manager.

In a terminal, execute the following commands:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | zsh
```

```bash
exec zsh
```

Then run the following command:

```bash
nvm -v
```

You should see a version.

Now let's install a node version:

```bash
nvm install 24
```

When the installation is finished, run:

```bash
node -v
```

If you see `v24.X.X`, the installation succeeded.

### Auto adjusting node version base on repository

We often are lazy people. We want our node version to change automatically according to the repository. Hence we should take advantage of our zsh. Open in vscode zsh by running the following

```bash
code ~/.zshrc
```

add the following at the end of the file

```zsh
autoload -U add-zsh-hook

load-nvmrc() {
  # Ensure nvm is available
  if ! type nvm &> /dev/null; then
    echo "⚠️ nvm is not installed. Please install nvm first."
    return
  fi

  # Only proceed if either .nvmrc or package.json exists
  if [ ! -f .nvmrc ] && [ ! -f package.json ]; then
    return
  fi

  local nvmrc_path desired_node_version current_node_version resolved_version

  # 1️⃣ Check for .nvmrc
  nvmrc_path="$(nvm_find_nvmrc)"
  if [ -n "$nvmrc_path" ]; then
    desired_node_version="$(cat "$nvmrc_path")"
  else
    # 2️⃣ Check package.json for engines.node
    if [ -f package.json ]; then
      desired_node_version="$(node -pe "require('./package.json').engines?.node || ''")"
    fi
  fi

  # 3️⃣ Fallback to nvm default if nothing found
  if [ -z "$desired_node_version" ]; then
    desired_node_version="$(nvm version default)"
  fi

  # 4️⃣ Determine if it's an exact version or a range
  # Exact version patterns: "18", "18.0.0", "v18.0.0"
  # Range patterns: ">=18.0.0", "^18.0.0", "~18.0.0", ">=18.0.0 <19.0.0", etc.
  if [[ "$desired_node_version" =~ ^v?[0-9]+(\.[0-9]+(\.[0-9]+)?)?$ ]]; then
    # It's an exact version - use it directly
    resolved_version="$desired_node_version"
  else
    # It's a range - resolve to latest LTS version matching the range
    local versions=($(nvm ls-remote --lts | grep -o "v[0-9]\+\.[0-9]\+\.[0-9]\+" | sed 's/v//'))
    resolved_version="$(npx -q semver -r "$desired_node_version" "${versions[@]}")"

    # Fallback to latest LTS if no match found
    if [ -z "$resolved_version" ]; then
      resolved_version="${versions[-1]}"
    fi
  fi

  current_node_version="$(nvm current)"

  # 5️⃣ Install if missing
  if [ "$(nvm version "$resolved_version")" = "N/A" ]; then
    echo "ℹ️  Node version $resolved_version is not installed."
    read "install_node?Do you want to install it now? (y/n) "
    if [[ "$install_node" =~ ^[Yy]$ ]]; then
      nvm install "$resolved_version"
    else
      echo "⚠️  Skipping Node version switch."
      return
    fi
  fi

  # 6️⃣ Switch if necessary
  if [ "$current_node_version" != "v$resolved_version" ] && [ "$current_node_version" != "$resolved_version" ]; then
    nvm use "$resolved_version" --silent
    echo "✅ Switched to Node $resolved_version"
  fi
}

# Hook into directory changes
type -a nvm &> /dev/null && add-zsh-hook chpwd load-nvmrc
type -a nvm &> /dev/null && load-nvmrc
```

### Python

For Python we will use [pyenv](https://github.com/pyenv/pyenv) as our version manager.

In a terminal, execute the following commands:

```bash
# Install pyenv via Git
curl https://pyenv.run | bash
```

Then, add pyenv to your shell by running:

```bash
# Add pyenv to PATH and initialize
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init --path)"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
exec zsh
```

Verify the installation:

```bash
pyenv -v
```

You should see a version printed, e.g., pyenv 2.X.X.

Now let's install a Python version:

```bash
pyenv install 3.12
```

When the installation is finished, run:

```bash
python -V
```

If you see Python 3.12.X, the installation succeeded.

### Auto adjusting Python version based on repository

We often want Python to switch automatically depending on the repository. We can leverage pyenv’s .python-version support in combination with zsh. Open your zsh config:

```bash
code ~/.zshrc
```

Add the following at the end of the file:

```zsh
autoload -U add-zsh-hook

load-pyenv-version() {
  # Ensure pyenv is available
  if ! type pyenv &> /dev/null; then
    echo "⚠️  pyenv is not installed. Please install pyenv first."
    return
  fi

  # Only proceed if project declares a Python version
  if [ ! -f .python-version ] && [ ! -f pyproject.toml ] && [ ! -f Pipfile ]; then
    return
  fi

  local resolved_version current_version pyproject_version pipfile_version

  # 1️⃣ Check .python-version
  if [ -f "$(pwd)/.python-version" ]; then
    resolved_version="$(cat "$(pwd)/.python-version")"
  else
    # 2️⃣ Check pyproject.toml (Poetry or PEP 621)
    if [ -f pyproject.toml ]; then
      pyproject_version="$(grep -E 'python\s*=\s*".*"' pyproject.toml | head -n1 | sed 's/.*"\(.*\)".*/\1/')"
      resolved_version="$pyproject_version"
    fi

    # 3️⃣ Check Pipfile
    if [ -f Pipfile ]; then
      pipfile_version="$(grep 'python_version' Pipfile | head -n1 | awk -F'"' '{print $2}')"
      resolved_version="${resolved_version:-$pipfile_version}"
    fi
  fi

  # 4️⃣ Fallback to pyenv global
  resolved_version="${resolved_version:-$(pyenv global)}"
  current_version="$(pyenv version-name)"

  # 5️⃣ Install if missing
  if ! pyenv versions --bare | grep -q "^$resolved_version"; then
    echo "ℹ️  Python version $resolved_version is not installed."
    read "install_py?Do you want to install it now? (y/n) "
    if [[ "$install_py" =~ ^[Yy]$ ]]; then
      pyenv install "$resolved_version"
    else
      echo "⚠️  Skipping Python version switch."
      return
    fi
  fi

  # 6️⃣ Switch if necessary
  if [ "$current_version" != "$resolved_version" ]; then
    pyenv local "$resolved_version"
    echo "✅ Switched to Python $resolved_version"
  fi
}

# Hook into directory changes
type -a pyenv &> /dev/null && add-zsh-hook chpwd load-pyenv-version
type -a pyenv &> /dev/null && load-pyenv-version.
```

## Check Setup

In order to check that you have installed everything correctly, run the following in a new terminal, or run `exec zsh` before running the following.

```bash
zsh <(curl -Ls https://raw.githubusercontent.com/NUH-Clinical-Innovation-Office/setup/main/check-script.sh)
```

If you get `🎉 Everything is properly installed! Your terminal is ready`, then you're good. If not, identify what is not installed and install them accordingly to the instructions above.

## AI Tools

AI coding assistants can significantly boost productivity, but it is crucial to understand their privacy implications and configure them properly. Here is what you need to know about popular AI coding tools:

### Privacy Considerations by Tool

[**Claude Code**](https://www.claude.com/product/claude-code) (Paid - Pro/Max plans):

- **Updated Policy (2025)**: As of October 2025, Anthropic now uses consumer account data (Free, Pro, Max) for training unless you opt out.
- **Action Required**: Navigate to Privacy Settings and disable "Help improve Claude" to opt out, and turn off location metadata.
- **Data Retention**: 5 years if opted in, 30 days if opted out
- **Business Users**: Claude for Work, Claude Gov, and API users are NOT affected - their data is never used for training

[**GitHub Copilot**](https://github.com/features/copilot) (Paid - Business/Enterprise recommended):

- **Individual Plan**: Data may be used for model fine-tuning unless you opt out
- **Business/Enterprise Plans**: Your code is NEVER used for training - this is guaranteed
- **Important Caveat**: All plans send your code to Microsoft/Azure servers for processing
- **Data Retention**: Prompts are discarded after suggestions; usage data retained for 24 months

[**Cursor**](https://cursor.com/features) (Paid - Business plan recommended):

- **Free/Pro Plans**: Privacy Mode is OFF by default - your code CAN be used for training
- **Business/Team Plans**: Privacy Mode is ON by default with zero data retention guarantee
- **Action Required for Free/Pro**: Manually enable Privacy Mode in settings to prevent training on your code
- **When Privacy Mode is ON**: Code is never stored or used for training by Cursor or third parties

[**OpenAI Codex**](https://openai.com/codex/) (Paid - ChatGPT Plus/Pro/Team/Enterprise):

- **Status Update**: Original Codex API was deprecated in March 2023; relaunched in 2025 as an autonomous coding agent integrated into ChatGPT
- **Pricing**: Included with ChatGPT Plus ($20/month), Pro ($200/month), Team, and Enterprise subscriptions
- **Privacy Policy**: Team/Enterprise users' code is NOT used for training by default; other users can opt out of training
- **Important Notes**: Code is processed in ephemeral cloud sandboxes on OpenAI servers; CLI keeps source code local and only sends prompts/context
- **Transparency Concern**: Lacks easily accessible privacy documentation specifically for Codex interactions

[**Qwen Coder**](https://github.com/QwenLM/qwen-code) (Free/Open Source):

- **Training Policy**: Does not use your code for training when used locally
- **API Authentication**: If using Qwen.ai or OpenAI-compatible APIs, you're subject to their respective privacy policies
- **Telemetry**: Collects anonymous usage statistics (can be disabled in settings)
- **Recommendation**: Best suited for non-sensitive code or when run completely locally

### Disabling VSCode Telemetry

Microsoft VSCode collects telemetry data by default. To disable it completely:

1. Open Command Palette (`Cmd+Shift+P` or `Ctrl+Shift+P`)
2. Type "Preferences: Open User Settings (JSON)"
3. Add these settings:

```json
{
  "telemetry.telemetryLevel": "off",
  "telemetry.enableCrashReporter": false,
  "telemetry.enableTelemetry": false
}
```

**Important Notes:**

- Extensions may have their own telemetry settings - check each extension's documentation
- Some extensions collect data independently of VSCode's telemetry settings
- Consider using VSCodium (fully open-source VSCode without telemetry) as an alternative

### Recommendations

1. **For Professional/Commercial Work**: Use paid enterprise plans (GitHub Copilot Business, Cursor Business, or Claude for Work) - these guarantee your code won't be used for training
2. **For Personal Projects**: If using free/pro consumer plans, always opt out of training and enable privacy modes
3. **For Sensitive Code**: Consider self-hosted solutions or tools with strong privacy guarantees
4. **Always**: Disable VSCode telemetry and review extension privacy policies before installation

### Personal Notes

Personally, I prefer using Claude Code because the terminal is an incredibly powerful tool. However, I understand that it can be intimidating for beginners. For those just starting out, I recommend using Codex from OpenAI this way you can obtain the ability to use the UI and Code (note that the usage is shared).

That said, it is important to treat these AI assistants as tools, and DO NOT vibe code if you are building software for longevity. There is a big difference between the two approaches:

- Using them as tools means you are guiding the AI like a senior developer giving direction, reviewing its work, and ensuring it aligns with your intent
- Vibe coding, on the other hand, is when you let the AI do all the work without truly understanding what it is doing

## License

Copyright 2025 NUH Department of Medicine

This project is licensed under the [Apache 2.0 License](LICENSE).

### What This Means For You

You may use, reproduce, and distribute this software, with or without modifications, provided that you:

1. **Include the License**: Provide a copy of the [LICENSE](LICENSE) file with any distribution
2. **Include the NOTICE**: Provide a copy of the [NOTICE](NOTICE) file with any distribution
3. **State Changes**: Clearly indicate any modifications you make to the original work
4. **Retain Copyright Notices**: Keep all copyright, patent, trademark, and attribution notices from the original source
5. **Provide Attribution**: Credit the original authors when using or modifying this work

### Patent Grant

Apache 2.0 includes an express patent license grant, protecting you from patent claims by contributors related to their contributions.

### No Trademark Rights

This license does not grant permission to use NUH trade names, trademarks, or service marks, except as required for reasonable and customary use in describing the origin of the work.

### Disclaimer

This software is provided "AS IS", WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and non-infringement.
