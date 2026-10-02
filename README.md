# Setup Guide

The current setup guide will be for MacOS only. If you are using any other OS please contact Yong Cheng for custom instructions.

Read the instructions carefully before executing any commands. In general it is important that you understand what you are installing and how it will help with your local development.

## Table of Contents

- [GitHub account](#github-account)
- [Command Line Tools](#command-line-tools)
- [Homebrew](#homebrew)
- [Visual Studio Code (VS Code)](#visual-studio-code-vs-code)
- [Shell configuration](#shell-configuration)
- [GitHub](#github)
- [Git](#git)
- [Docker](#docker)
  - [Installing OrbStack](#installing-orbstack)
  - [Why OrbStack over Docker Desktop?](#why-orbstack-over-docker-desktop)
- [Programming Languages](#programming-languages)
  - [Installing mise](#installing-mise)
  - [Node.js](#nodejs)
    - [Bun](#bun)
  - [Python](#python)
  - [Go](#go)
  - [Java](#java)
  - [Auto adjusting versions based on repository](#auto-adjusting-versions-based-on-repository)
    - [Reading versions from build files](#reading-versions-from-build-files)
  - [Migrating from nvm, pyenv, goenv and SDKMAN!](#migrating-from-nvm-pyenv-goenv-and-sdkman)
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

source $ZSH/oh-my-zsh.sh

# PATH exports
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
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

1. `Enter a passphrase for your new SSH key (Optional)`. Type something you want and that you'll remember. It's a password to protect your private key stored on your hard drive. Then press `Enter`.

2. `Title for your SSH key`. You can used the default by just pressing `Enter`.

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

## Docker

Docker is a platform that allows you to run applications in isolated containers. We recommend using [OrbStack](https://orbstack.dev/) instead of Docker Desktop as it is faster, lighter (uses significantly less memory), and provides a better developer experience on macOS.

### Installing OrbStack

Run the following command in the terminal:

```bash
brew install --cask orbstack
```

After installation, launch OrbStack:

```bash
open -a OrbStack
```

OrbStack will guide you through the initial setup. It includes Docker, Docker Compose, and Kubernetes support out of the box.

To verify the installation:

```bash
docker --version
docker compose version
```

You should see version information for both commands.

### Why OrbStack over Docker Desktop?

- **Performance**: Up to 2x faster than Docker Desktop
- **Memory Efficiency**: Uses ~50% less memory and CPU
- **Speed**: Starts containers almost instantly
- **Native Integration**: Better macOS integration with less overhead
- **Free for Commercial Use**: No licensing restrictions unlike Docker Desktop

**Note**: If you already have Docker Desktop installed, OrbStack can coexist with it, but it's recommended to uninstall Docker Desktop to avoid conflicts:

```bash
# Uninstall Docker Desktop (optional)
brew uninstall --cask docker
```

## Programming Languages

Within an organization, you will often work with multiple programming languages. It is important to install each language using a version manager to ensure consistency and avoid conflicts between projects. If you already have your own preferred language version manager, go ahead and use it. However, if you have no idea you can follow the instructions below.

If you are working in NUH Clinical Innovation Office, install all of the below.

### Why use a version manager instead of installing directly?

When you install a language directly (e.g. downloading Node.js or Python from the official website, or running `brew install node`), you get a single fixed version installed globally on your machine. This works fine for personal projects, but causes problems in a team or multi-project environment:

- **Version conflicts**: Project A might require Node.js 18 while Project B requires Node.js 24. A direct install can only give you one version at a time.
- **No easy switching**: Upgrading for one project can break another. Downgrading is painful and error-prone.
- **Inconsistency across the team**: If everyone installs different versions manually, bugs appear on some machines but not others.

A **version manager** solves all of this by letting you:

- Install and store **multiple versions** of a language side by side
- **Switch between versions** instantly per project or directory
- **Automatically use the right version** when you enter a project folder (via `mise.toml`, `.nvmrc`, `.python-version`, `.go-version`, or `.sdkmanrc` files, or build files such as `package.json`)
- Ensure every developer on the team runs the **exact same version**, eliminating "works on my machine" issues

Think of it this way: a direct install is like having only one pair of shoes, while a version manager is like having a shoe rack — you pick the right pair for the right occasion.

### Installing mise

We use [mise](https://mise.jdx.dev) as our single version manager for Node.js, Python, Go and Java (including Maven and Gradle). One tool replaces `nvm`, `pyenv`, `goenv` and `SDKMAN!`, and it keeps your terminal fast: activating mise takes a few milliseconds, whereas loading all four separate version managers can add over a second to every new terminal.

In a terminal, execute the following command:

```bash
brew install mise
```

Open your zsh config:

```bash
code ~/.zshrc
```

Add the following at the **very end** of the file:

```zsh
# ─── Tool Initializations ────────────────────────────────────────────────────

# mise manages node, python, go, java, gradle and maven, and auto-switches
# versions on cd from mise.toml, .nvmrc, .python-version, .go-version, .sdkmanrc
# (build files like package.json are handled by the hook further below)
export PATH="$PATH:$HOME/go/bin"
eval "$(mise activate zsh)"
```

`$HOME/go/bin` is where binaries installed with `go install` end up, so they are available on your `PATH`.

Keep the mise block (and the hook from [Reading versions from build files](#reading-versions-from-build-files)) as the **last** lines of `~/.zshrc`. If a line after it changes `PATH`, mise runs twice on every new terminal and prints its warnings twice. Installers such as bun add their lines to the end of the file, so move the mise block back to the end after installing them.

Next, allow mise to read the version files used by other version managers (`.nvmrc`, `.python-version`, `.go-version`, `.sdkmanrc`), so existing projects work without changes:

```bash
mise settings add idiomatic_version_file_enable_tools node
mise settings add idiomatic_version_file_enable_tools python
mise settings add idiomatic_version_file_enable_tools go
mise settings add idiomatic_version_file_enable_tools java
```

Then restart the shell and verify the installation:

```bash
exec zsh
mise --version
```

You should see a version printed, e.g., `2026.X.X macos-arm64`. If anything looks wrong later on, `mise doctor` will diagnose common problems.

### Node.js

Install Node.js and make it the default version:

```bash
mise use -g node@24
```

When the installation is finished, run:

```bash
node -v
```

If you see `v24.X.X`, the installation succeeded.

#### Bun

We use [bun](https://bun.sh) as our package manager (instead of npm/yarn/pnpm).

Install it:

```bash
curl -fsSL https://bun.sh/install | bash
```

The installer adds a few lines to the end of `~/.zshrc`. Move the mise block back below them so it stays last (see [Installing mise](#installing-mise)).

```bash
exec zsh
```

Verify the install:

```bash
bun -v
```

You should see a version. Use `bun install`, `bun add`, `bun run` etc. in place of their `npm` equivalents.

### Python

Install Python and make it the default version:

```bash
mise use -g python@3.12
```

When the installation is finished, run:

```bash
python -V
```

If you see `Python 3.12.X`, the installation succeeded.

mise installs prebuilt Python binaries by default, which is much faster than compiling. If a package with C extensions misbehaves, you can make mise compile Python from source instead (like `pyenv` does) with `mise settings set python.compile true`.

### Go

Install Go and make it the default version:

```bash
mise use -g go@1.24
```

When the installation is finished, run:

```bash
go version
```

If you see `go version go1.24.X`, the installation succeeded.

### Java

Install Java and make it the default version. We use a [Temurin](https://adoptium.net/) (Eclipse Adoptium) build, the most widely used free OpenJDK distribution:

```bash
mise use -g java@temurin-25
```

You can list all available Java versions with `mise ls-remote java`. When the installation is finished, run:

```bash
java -version
```

If you see `openjdk version "25.X.X"`, the installation succeeded.

mise can also manage Maven and Gradle:

```bash
mise use -g maven@3 gradle@9
```

Most projects ship their own `./mvnw` or `./gradlew` wrapper, which downloads the exact Maven or Gradle version the project needs, so the global version mostly matters for creating new projects.

### Auto adjusting versions based on repository

Once mise is activated in your `~/.zshrc`, it automatically switches versions whenever you `cd` into a project folder. mise looks for the following files in the project folder (and its parent folders):

| File              | Tools                  | Example                |
| ----------------- | ---------------------- | ---------------------- |
| `mise.toml`       | any                    | see below              |
| `.nvmrc`          | Node.js                | `24`                   |
| `.node-version`   | Node.js                | `24`                   |
| `.python-version` | Python                 | `3.12`                 |
| `.go-version`     | Go                     | `1.24.0`               |
| `.java-version`   | Java                   | `temurin-25`           |
| `.tool-versions`  | any                    | `node 24`              |
| `.sdkmanrc`       | Java                   | `java=25.0.3-tem`      |

For new projects, prefer a single `mise.toml` in the root of the repository. Create one by running `mise use` (without `-g`) inside the project folder:

```bash
mise use node@24 python@3.12
```

This produces a `mise.toml` like:

```toml
[tools]
node = "24"
python = "3.12"
```

Commit this file so everyone on the team uses the same versions. When a teammate enters the project for the first time, they run `mise install` to install any missing versions.

#### Reading versions from build files

Many projects only declare their version in a build file, which mise does **not** read. We add a zsh hook that fills this gap. When no version file above is found, it falls back to:

| Tool    | Build files (checked in order)                                         | Example                               |
| ------- | ---------------------------------------------------------------------- | ------------------------------------- |
| Node.js | `package.json` `engines.node`                                          | `"node": ">=20"`                      |
| Python  | `pyproject.toml` (uv, Poetry, PEP 621), then `Pipfile`                 | `requires-python = ">=3.12"` or Poetry's `python = "^3.12"` |
| Go      | `go.mod` `toolchain` line, then `go` directive                         | `go 1.24`                             |
| Java    | Gradle (`gradle/libs.versions.toml`, `build.gradle(.kts)`), then Maven `pom.xml` | `jvmToolchain(21)`, `<java.version>25</java.version>` |

How the hook behaves:

- A version file (`.nvmrc`, `mise.toml`, ...) always wins over a build file. So does `devEngines.runtime` in `package.json`, which mise reads itself.
- Node.js ranges such as `>=20` resolve to the newest **already installed** version that matches. Python ranges use the lowest version mentioned (`>=3.12` becomes `3.12`). Java uses the [Temurin](https://adoptium.net/) build of the major version found (old style `1.8` / `VERSION_1_8` means Java 8).
- uv projects usually also have a `.python-version` file (created by `uv python pin`), which mise reads directly.
- Gradle settings are checked before Maven, and the Gradle version catalog before `build.gradle(.kts)`. Maven reads `maven.compiler.release`, `maven.compiler.target`, `maven.compiler.source`, `java.version` or the compiler plugin's `<release>`.
- If the version is not installed, it asks whether to install it. If you answer no, it will not ask again for that version until you open a new terminal.
- When you leave the project, your default versions come back.
- Until mise 2026.11.0, mise itself also reads the `go` line in `go.mod` and prints a `deprecated [idiomatic.go.mod.go-directive]` warning on every `cd`. Adding a `toolchain go1.X.Y` line to `go.mod` removes it. The hook keeps working after mise stops reading `go.mod`.

Open your zsh config:

```bash
code ~/.zshrc
```

Add the following at the end of the file, directly after the `eval "$(mise activate zsh)"` line:

```zsh
# ─── Auto Version Switching ──────────────────────────────────────────────────

# mise already switches versions from mise.toml and version files (.nvmrc,
# .python-version, .go-version, .sdkmanrc). This hook adds the fallbacks mise
# does not read: package.json, pyproject.toml, Pipfile, go.mod, Maven and Gradle.

autoload -U add-zsh-hook

# Versions the user declined to install in this shell, so we only ask once
typeset -gA _mise_declined
# Node engines range -> newest matching installed version
typeset -gA _mise_range_cache

# Succeeds if directory $1 pins tool $2 in a file mise reads itself
_mise_has_native() {
  local dir=$1 tool=$2 f
  case $tool in
    node)   [[ -f $dir/.nvmrc || -f $dir/.node-version ]] && return 0
            # mise reads package.json devEngines.runtime (name "node") itself
            [[ -f $dir/package.json ]] && grep -q '"devEngines"' $dir/package.json \
              && node -e "const r = require(process.argv[1]).devEngines?.runtime;
                          process.exit([r].flat().some(x => x?.name === 'node') ? 0 : 1)" \
                   "$dir/package.json" 2>/dev/null && return 0 ;;
    python) [[ -f $dir/.python-version ]] && return 0 ;;
    go)     [[ -f $dir/.go-version ]] && return 0 ;;
    java)   [[ -f $dir/.java-version ]] && return 0
            [[ -f $dir/.sdkmanrc ]] && grep -qE '^[[:space:]]*java[[:space:]]*=' $dir/.sdkmanrc && return 0 ;;
  esac
  for f in mise.toml .mise.toml mise.local.toml .config/mise.toml; do
    [[ -f $dir/$f ]] && grep -qE "^[[:space:]]*\"?$tool\"?[[:space:]]*=" $dir/$f && return 0
  done
  [[ -f $dir/.tool-versions ]] && grep -qE "^$tool[[:space:]]" $dir/.tool-versions
}

# Each _mise_detect_<tool> reads the build files in directory $1 and sets REPLY
# to the version found (empty if none)

_mise_detect_node() {
  REPLY=
  [[ -f $1/package.json ]] || return
  local range match
  local -a installed
  range="$(node -pe "require(process.argv[1]).engines?.node || ''" "$1/package.json" 2>/dev/null)"
  [[ -n $range ]] || return

  # Exact version (e.g. 24 or 24.1.0): use as is
  if [[ $range =~ '^v?[0-9]+(\.[0-9]+){0,2}$' ]]; then
    REPLY=${range#v}
    return
  fi

  # Range (e.g. >=20): newest installed version that satisfies it
  # (cached, as bunx is slow to run on every cd)
  installed=(${(f)"$(mise ls --installed --json node 2>/dev/null | grep -oE '"version": *"[0-9][^"]*"' | grep -oE '[0-9][^"]*')"})
  local key="$range|$installed"
  if [[ -z ${_mise_range_cache[$key]+set} ]]; then
    (( $#installed )) && match="$(bunx -q semver -r "$range" $installed 2>/dev/null | tail -n1)"
    _mise_range_cache[$key]=$match
  fi
  match=${_mise_range_cache[$key]}

  # Nothing installed matches: fall back to the lowest major version in the range
  REPLY=${match:-$(grep -oE '[0-9]+' <<< $range | head -n1)}
}

_mise_detect_python() {
  REPLY=
  if [[ -f $1/pyproject.toml ]]; then
    # uv / Poetry 2 / PEP 621 (requires-python = ">=3.12") or Poetry 1 (python = "^3.12")
    REPLY="$(grep -E "^[[:space:]]*(requires-)?python[[:space:]]*=[[:space:]]*[\"']" $1/pyproject.toml \
      | head -n1 | cut -d= -f2- | grep -oE '[0-9]+(\.[0-9]+)*' | head -n1)"
  fi
  if [[ -z $REPLY && -f $1/Pipfile ]]; then
    REPLY="$(grep -E 'python_version' $1/Pipfile | head -n1 | awk -F'"' '{print $2}')"
  fi
}

_mise_detect_go() {
  REPLY=
  [[ -f $1/go.mod ]] || return
  # Prefer the toolchain line (exact version), else the go directive
  REPLY="$(grep -E '^toolchain go[0-9]' $1/go.mod | head -n1 | sed 's/^toolchain go//')"
  [[ -n $REPLY ]] || REPLY="$(grep -E '^go [0-9]' $1/go.mod | head -n1 | awk '{print $2}')"
}

_mise_detect_java() {
  REPLY=
  local major gradle_file

  # 1. Gradle version catalog
  if [[ -f $1/gradle/libs.versions.toml ]]; then
    major="$(grep -E '^[[:space:]]*java[[:space:]]*=' $1/gradle/libs.versions.toml \
      | head -1 | grep -E -o '[0-9]+' | head -1)"
  fi

  # 2. Gradle build file literal
  if [[ -z $major ]]; then
    [[ -f $1/build.gradle.kts ]] && gradle_file=$1/build.gradle.kts
    [[ -f $1/build.gradle ]] && gradle_file=$1/build.gradle
    if [[ -n $gradle_file ]]; then
      major="$(grep -E -o '(sourceCompatibility|targetCompatibility|languageVersion|JavaLanguageVersion\.of|jvmToolchain)[^0-9]*(1[._])?[0-9]+' $gradle_file \
        | head -1 | grep -E -o '(1[._])?[0-9]+$')"
    fi
  fi

  # 3. Maven
  if [[ -z $major && -f $1/pom.xml ]]; then
    major="$(grep -E -o '<(maven\.compiler\.(release|target|source)|java\.version|release)>(1\.)?[0-9]+' $1/pom.xml \
      | head -1 | grep -E -o '(1\.)?[0-9]+$')"
  fi

  # Old style 1.8 / VERSION_1_8 means Java 8
  major=${major#1[._]}

  # Plain java@25 in mise is OpenJDK, so ask for Temurin explicitly
  [[ -n $major ]] && REPLY=temurin-$major
}

# Switch tool $1 to version $2 for this shell, offering to install it if missing
_mise_use() {
  local tool=$1 version=$2 var="MISE_${(U)1}_VERSION" install
  [[ ${(P)var} == $version ]] && return

  if ! mise where "$tool@$version" &>/dev/null; then
    [[ -n ${_mise_declined[$tool@$version]} ]] && { unset $var; return }
    echo "ℹ️  $tool $version is not installed."
    read "install?Do you want to install it now? (y/n) "
    if [[ ! $install =~ ^[Yy]$ ]]; then
      _mise_declined[$tool@$version]=1
      echo "⚠️  Skipping $tool version switch."
      unset $var
      return
    fi
    mise install "$tool@$version" || { unset $var; return }
  fi

  export $var=$version
  echo "✅ Switched to $tool $version"
}

load-project-versions() {
  command -v mise &>/dev/null || return
  local tool dir

  for tool in node python go java; do
    REPLY=
    dir=$PWD
    # Walk up to the nearest folder that declares a version for this tool
    while true; do
      _mise_has_native $dir $tool && { REPLY=; break }
      _mise_detect_$tool $dir
      [[ -n $REPLY || $dir == / ]] && break
      dir=${dir:h}
    done

    if [[ -n $REPLY ]]; then
      _mise_use $tool $REPLY
    else
      # A version file or the global config applies, let mise handle it
      unset "MISE_${(U)tool}_VERSION"
    fi
  done
}

# Register hook and run on shell start
add-zsh-hook chpwd load-project-versions
load-project-versions
```

Then restart the shell with `exec zsh`.

### Migrating from nvm, pyenv, goenv and SDKMAN!

If you previously followed an older version of this guide, you can move your existing setup to mise:

1. Back up your zsh config: `cp ~/.zshrc ~/.zshrc.bak`
2. Follow [Installing mise](#installing-mise) above.
3. Reuse the Node.js and Python versions you already installed:

   ```bash
   mise sync node --nvm
   mise sync python --pyenv
   ```

4. Set your default versions, e.g. `mise use -g node@24 python@3.12 go@1.24 java@temurin-25 maven@3 gradle@9`. Go and Java versions from goenv and SDKMAN! are installed fresh by mise.
5. In `~/.zshrc`, remove the `nvm`, `pyenv`, `goenv` and `sdkman` initialization blocks, the `load-nvmrc`, `load-pyenv-version`, `load-goenv-version` and `load-sdkman-java` functions, and their `add-zsh-hook` lines. The single hook in [Reading versions from build files](#reading-versions-from-build-files) replaces all four.
6. Restart the shell with `exec zsh` and confirm `which node python go java` all point into `~/.local/share/mise`.

`mise sync` creates links into `~/.nvm` and `~/.pyenv` rather than copies. Before deleting those folders, reinstall the versions under mise, for example:

```bash
mise uninstall node@24 && mise install node@24
mise uninstall --all python && mise install python@3.12
rm -rf ~/.nvm ~/.pyenv ~/.goenv ~/.sdkman
brew uninstall pyenv goenv
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

[**Claude Code**](https://www.claude.com/product/claude-code) (Paid - Pro/Max plans) (Recommended):

- **Updated Policy (2025)**: As of October 2025, Anthropic now uses consumer account data (Free, Pro, Max) for training unless you opt out.
- **Action Required**: Navigate to Privacy Settings and disable "Help improve Claude" to opt out, and turn off location metadata.
- **Data Retention**: 5 years if opted in, 30 days if opted out
- **Business Users**: Claude for Work, Claude Gov, and API users are NOT affected - their data is never used for training

[**OpenAI Codex**](https://openai.com/codex/) (Paid - ChatGPT Plus/Pro/Team/Enterprise):

- **Status Update**: Original Codex API was deprecated in March 2023; relaunched in 2025 as an autonomous coding agent integrated into ChatGPT
- **Pricing**: Included with ChatGPT Plus ($20/month), Pro ($200/month), Team, and Enterprise subscriptions
- **Privacy Policy**: Team/Enterprise users' code is NOT used for training by default; other users can opt out of training
- **Important Notes**: Code is processed in ephemeral cloud sandboxes on OpenAI servers; CLI keeps source code local and only sends prompts/context
- **Transparency Concern**: Lacks easily accessible privacy documentation specifically for Codex interactions

[**Alibaba Cloud Coding Plan**](https://www.alibabacloud.com/help/en/model-studio/coding-plan) (Paid - subscription plans):

- **What It Is**: A monthly subscription by Alibaba Cloud's Model Studio offering flat-rate access to multiple top AI coding models, avoiding unpredictable API billing
- **Pricing**: Lite plan ($10/month, ~18,000 requests/month); Pro plan ($50/month, ~90,000 requests/month)
- **Available Models**: Qwen3.5-Plus, Qwen3-Coder-Next, GLM-4.7, Kimi K2.5, and more — switchable via `/model` command
- **Compatible Tools**: Works with Claude Code, Qwen Code CLI, Cursor, Cline, OpenCode, OpenClaw, and any tool supporting OpenAI or Anthropic API protocols
- **Data Privacy**: Code is processed on Alibaba Cloud servers (Singapore/Virginia); review [Alibaba Cloud's privacy policy](https://www.alibabacloud.com/help/en/model-studio/coding-plan) before use — particularly important for sensitive or proprietary code
- **Setup**: Use the plan-specific API key (`sk-sp-xxxxx`) with the base URL `https://coding-intl.dashscope.aliyuncs.com/v1` (OpenAI-compatible) or `https://coding-intl.dashscope.aliyuncs.com/apps/anthropic` (Anthropic-compatible)
- **Note**: API key must only be used in interactive coding tools; using it in automated scripts or batch scenarios may result in a suspended subscription

To use with Claude Code:

```bash
export ANTHROPIC_BASE_URL=https://coding-intl.dashscope.aliyuncs.com/apps/anthropic
export ANTHROPIC_API_KEY=YOUR_CODING_PLAN_API_KEY
export ANTHROPIC_MODEL=qwen3.5-plus
claude
```

### Using Alternative Endpoints to Save Cost

Claude Code supports alternative API endpoints via environment variables. This lets you use different models (e.g., Alibaba's Qwen, OpenAI models) that may be cheaper or faster for specific tasks.

**Trade-offs:**

- **Quality**: Anthropic's Claude models generally produce higher quality output for complex reasoning, debugging, and architecture decisions. Third-party models may struggle with nuanced edge cases.
- **Speed**: Alternative endpoints often respond faster but may require more iterations to get correct results — net time savings vary.
- **Cost**: Qwen and similar models cost significantly less per token (~10-50x cheaper). Useful for straightforward tasks where Claude would be overkill.

**When to use which:**

| Task                                         | Model                                |
| -------------------------------------------- | ------------------------------------ |
| Complex debugging, architecture, code review | Anthropic Claude                     |
| Simple refactors, boilerplate, documentation | Alternative (Qwen, etc.)             |
| Exploratory prototyping                      | Alternative first, escalate if stuck |

**Usage with aliases:**

Add these to your `~/.aliases` or `~/.zshrc`:

```zsh
# Qwen (Alibaba Cloud Coding Plan)
claude-qwen() {
  local OLD_BASE_URL="$ANTHROPIC_BASE_URL"
  local OLD_AUTH_TOKEN="$ANTHROPIC_AUTH_TOKEN"
  local OLD_MODEL="$ANTHROPIC_MODEL"
  local OLD_DISABLE="$CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC"

  export ANTHROPIC_BASE_URL="https://coding-intl.dashscope.aliyuncs.com/apps/anthropic"
  export ANTHROPIC_API_KEY="YOUR-API-KEY"
  export ANTHROPIC_MODEL="qwen3.5-plus"
  export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1

  claude "$@"

  # We need this to set the values back to the original so that when you quit and launch claude it will be back to your anthropic subscription
  export ANTHROPIC_BASE_URL="$OLD_BASE_URL"
  export ANTHROPIC_AUTH_TOKEN="$OLD_AUTH_TOKEN"
  export ANTHROPIC_MODEL="$OLD_MODEL"
  export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC="$OLD_DISABLE"
}
```

**Usage:**

```bash
claude-qwen                              # Qwen via Alibaba endpoint
ANTHROPIC_MODEL=qwen3-coder-next claude  # One-off with different model
```

**Note:** Replace `YOUR-API-KEY` with your actual Alibaba Coding Plan API key.

Notes:
Other AI coding tools such as Cursor, GitHub Copilot, and Qwen Code etc. have been intentionally excluded from this guide to keep things focused. While these are capable tools that can support productive software development, the options listed here are ones I have personally used and evaluated. In my experience, they offer a stronger overall experience and value, though this reflects my own judgment and may not align with everyone's preferences. You are encouraged to explore other tools and choose what works best for your workflow.

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

Copyright 2026 NUH Department of Medicine

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
