# macbook-bootstrapping

A small collection of scripts and dotfiles to bootstrap a new macOS (Apple Silicon) development machine.

## Overview

This repository automates common setup tasks for a new Mac: installing Homebrew and useful CLI tools, configuring a zsh-based shell with useful plugins and a welcome message, and provisioning utilities like `kubectl`, `awscli`, and `iTerm2`.

## Features

- Installs Homebrew (if missing) and updates it.
- Installs and configures zsh helpers: `powerlevel10k`, `zsh-autosuggestions`, `zsh-syntax-highlighting`.
- Installs or verifies Git, `kubectl`, `kubectx`, `awscli`, and `iTerm2`.
- Appends safe includes to your shell config to source the bundled additions.

## Prerequisites

- A Mac running macOS (This is tested in Apple Silicon).
- Xcode Command Line Tools (the setup script will prompt or require them for some installs).
- An internet connection and disable VPN is any for downloading Homebrew, packages, and theme/plugins.

## Quickstart

1. Clone this repository:

	git clone https://github.com/Vinay-Venkatesh/macbook-bootstrapping.git
	cd macbook-bootstrapping

2. Inspect the main setup script before running it:

	- See [dotfiles/setup.sh](dotfiles/setup.sh) for actions performed.

3. Run the bootstrap script:

	bash dotfiles/setup.sh

4. When the script finishes: open iTerm2 and run the Powerlevel10k configuration (`p10k configure`) to finish shell visuals.

Important: Always review scripts before running them. The setup script makes changes to your `~/.zshrc` and installs tools.

## What’s in this repo

- [dotfiles/setup.sh](dotfiles/setup.sh) — main installer and bootstrap orchestration.
- [dotfiles/zsh/zsh-additions.sh](dotfiles/zsh/zsh-additions.sh) — zsh sources for themes and plugins.
- [dotfiles/zsh/welcome.sh](dotfiles/zsh/welcome.sh) — small welcome message fetched daily.
- [dotfiles/iterm2/iterm2-conf.itermexport](dotfiles/iterm2/iterm2-conf.itermexport) — an iTerm2 export (optional import).

## Customization

- Edit the scripts in `dotfiles/` to add or remove packages, or change where files are sourced from.
- If you prefer to not modify your `~/.zshrc`, back it up before running the script.

## Safety & Notes

- The installer attempts to be idempotent (it checks for existing installs), but you should still review the scripts first.
- The script prompts to configure `git` if it's not set. You can run the git configuration steps manually if preferred.
