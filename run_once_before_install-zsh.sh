#!/usr/bin/env bash

if ! command -v zsh &> /dev/null; then
    echo "zsh not found. Installing with homebrew..."
    # Install rustup in non-interactive mode
    brew install zsh
    echo "✅ zsh installed."
else
    echo "zsh is already installed."
fi
