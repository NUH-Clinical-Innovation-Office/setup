# Setup Guide

The current setup guide will be for MacOS only. If you are using any other OS please contact Yong Cheng for custom instructions.

Read the instructions carefully before executing any commands. In general it is important that you understand of you are installing and how it will help with your local development.

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

  local nvmrc_path desired_node_version current_node_version resolved_version versions match

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

  # 4️⃣ List installed versions or available LTS versions
  versions=($(nvm ls-remote --lts | grep -o "v[0-9]\+\.[0-9]\+\.[0-9]\+" | sed 's/v//'))

  # Normalize simple major versions (e.g., '18' -> '>=18.0.0 <19.0.0')
  if [[ "$desired_node_version" =~ ^[0-9]+$ ]]; then
    desired_node_version=">=${desired_node_version}.0.0 <$((${desired_node_version}+1)).0.0"
  fi

  # Use npx semver to find the latest matching version
  resolved_version="$(npx -q semver -r "$desired_node_version" "${versions[@]}")"
  resolved_version="${resolved_version:-${versions[-1]}}"

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
  if [ "$current_node_version" != "$resolved_version" ]; then
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
  if ! pyenv versions --bare | grep -q "^$resolved_version\$"; then
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
