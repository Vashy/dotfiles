#!/usr/bin/env bash

if ! command -v brew &> /dev/null; then
    echo "homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "✅ homebrew installed."
    echo >> $HOME/.bashrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/vashy/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo "✅ homebrew added to ~/.bashrc"
else
    echo "homebrew is already installed."
fi
