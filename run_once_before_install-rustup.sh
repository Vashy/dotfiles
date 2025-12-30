#!/usr/bin/env bash

if ! command -v rustup &> /dev/null; then
    echo "🚀 Rust not found. Installing rustup..."
    # Install rustup in non-interactive mode
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    # Source the cargo env so it's available for the rest of this session
    source "$HOME/.cargo/env"
else
    echo "✅ Rust is already installed."
fi
